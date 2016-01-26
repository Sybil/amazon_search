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
    @responses = AmazonService.new(@request.keywords).perform

  end
  
  def index
    @requests = Request.includes(:user)
  end


private
  def request_params
    params.require(:request).permit(:keywords)
  end  

end
