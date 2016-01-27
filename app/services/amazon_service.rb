class AmazonService
  attr_reader :request_analysis

  def initialize(request_analysis)
    @request_analysis = request_analysis
  end

  def request_amazon_api
    keywords = request_analysis.entities["search_query"].first.value
    $vacuum.item_search(
      query: {
        'Keywords' => keywords,
        'SearchIndex' => request_analysis.intent
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
