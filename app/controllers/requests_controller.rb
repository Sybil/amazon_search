class RequestsController < ApplicationController

def new 
  @request=Request.new
end

def create 
  @request = Request.new(request_params)
 
  @request.save
  redirect_to @request
end

def show
  @request = Request.find(params[:id])
  amazon = Vacuum.new
amazon.configure(
    aws_access_key_id: Rails.application.secrets.amazon_access_key,
    aws_secret_access_key: Rails.application.secrets.amazon_secret_key,
    associate_tag: 'Project'
)
  @response = amazon.item_search(
    query: {
      'Keywords' => @request.keywords,
      'SearchIndex' => 'All'
    }
  )

end

def index
  @requests = Request.all
end


private
  def request_params
    params.require(:request).permit(:keywords)
  end  

end
