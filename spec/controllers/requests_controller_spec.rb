describe RequestsController do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in FactoryGirl.create(:user)
  end

  describe "create" do

    let(:req) {Request.new(keywords: keywords)}
    let(:keywords) {''}
    subject do
      post :create, {request: {keywords: keywords}}
    end

    context "when the request is empty" do
      it {should be_unprocessable_entity}
    end

    let(:keywords) {'basic keywords'}
    context "when the request is a basic string" do
      it "creates a request" do
        expect{subject}.to change{Request.count}.by(1)
      end
      it "redirects" do
        expect(subject).to redirect_to(action: :show, id: Request.last.id)
      end
    end
  end

   describe "index" do
    subject do
      get :index
    end

    context "when I get the request index" do
      it "renders the index template" do
        subject
        expect(response).to render_template("index")
      end
      it "returns all the requests" do
        expect(Request).to receive(:includes)
        subject
      end
    end
  end
end
