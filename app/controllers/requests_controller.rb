class RequestsController < ApplicationController

  before_action :authenticate_user!

  def new 
    @request=Request.new
  end
  
  def create
    request = Request.new(request_params)
    request.user_id = current_user.id
    request.save
    redirect_to request
  end
  
  def show
    @request = Request.find(params[:id])
    @request_analysis = NlpService.new(@request.keywords).perform
    @responses = AmazonService.new(@request_analysis).perform

  end
  
  def index
    @requests = Request.includes(:user)
  end


private
  def request_params
    params.require(:request).permit(:keywords)
  end  

end
