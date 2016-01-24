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
end

def index
  @requests = Request.all
end


private
  def request_params
    params.require(:request).permit(:keywords)
  end  

end
