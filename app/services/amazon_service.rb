class AmazonService
  attr_reader :keywords

  def initialize(keywords)
    @keywords = keywords
  end

  def request_amazon_api
    amazon = Vacuum.new
    amazon.configure(
      aws_access_key_id: Rails.application.secrets.amazon_access_key,
      aws_secret_access_key: Rails.application.secrets.amazon_secret_key,
      associate_tag: 'RoR project'
    )
    amazon.item_search(
      query: {
        'Keywords' => keywords,
        'SearchIndex' => 'All'
      }
    )   
  end

  def parse_amazon_xml(xml_string)
    results = xml_string.to_h["ItemSearchResponse"]["Items"]["Item"]
    results.to_s.scan(/(?<="Title"=>").*?(?="}})/)   
  end

  def perform
    xml_result = request_amazon_api
    parse_amazon_xml(xml_result)
  end

end
