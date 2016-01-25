describe AmazonService do

  around(:each) do | test |
    Timecop.freeze(Time.parse('2016-01-25T06:30:58')) do
      test.run
    end
  end

  describe "request_amazon_api" do

    let!(:keywords) {'shiatsu'}
    subject do
      AmazonService.new(keywords)
    end

    context "when I request Amazon API with a basic keyword", vcr: {cassette_name: 'basic_keyword'} do
      it "returns a xml with amazon results" do
        expect(subject.request_amazon_api.body).to include('Shiatsu')
      end
    end
  end

  describe "parse_amazon_xml" do

    let!(:keywords) {'shiatsu'}
    let(:xml) {AmazonService.new(keywords).request_amazon_api}
    subject do
      AmazonService.new(keywords)
    end

    context "when I parse amazon xml", vcr: {cassette_name: 'basic_keyword'} do
      it "returns products titles" do
        expect(subject.parse_amazon_xml(xml).first).to include('Shiatsu')
      end
    end
  end

  describe "perform" do
    let!(:keywords) {'shiatsu'}
    subject do
      AmazonService.new(keywords)
    end
    
    context "when I ask amazon", vcr: {cassette_name: 'basic_keyword'} do
      it "gives good products" do
        expect(subject.perform.first).to include('Shiatsu')
    
      end
    end
  end
end
