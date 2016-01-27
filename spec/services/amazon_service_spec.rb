describe AmazonService do

  around(:each) do | test |
    Timecop.freeze(Time.parse('2016-01-27T05:35:59')) do
      test.run
    end
  end
   
  let!(:request_analysis) { 
    OpenStruct.new({
      intent: 'Books', 
      entities: {"search_query"=>[OpenStruct.new(value: 'shiatsu')]} 
    }) 
  }
    
  describe "request_amazon_api" do
    subject do
      AmazonService.new(request_analysis)
    end

    context "when I request Amazon API with a basic keyword", vcr: {cassette_name: 'basic_keyword'} do
      it "returns a xml with amazon results" do
        expect(subject.request_amazon_api.body).to include('Shiatsu')
      end
    end
  end

  describe "parse_amazon_xml" do

    let(:xml) {AmazonService.new(request_analysis).request_amazon_api}
    subject do
      AmazonService.new(request_analysis)
    end

    context "when I parse amazon xml", vcr: {cassette_name: 'basic_keyword'} do
      it "returns products titles" do
        expect(subject.parse_amazon_xml(xml).first).to include('Shiatsu')
      end
    end
  end

  describe "perform" do
    subject do
      AmazonService.new(request_analysis)
    end
    
    context "when I ask amazon", vcr: {cassette_name: 'basic_keyword'} do
      it "gives good products" do
        expect(subject.perform.first).to include('Shiatsu')
      end
    end
  end
end
