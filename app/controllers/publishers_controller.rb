class PublishersController < ApplicationController
  
  def new
    @publisher = Publisher.new

  end
  
  def create
    @publisher = Publisher.new(params[:publisher])
    @publisher.save
    
    redirect_to :action => 'new'
  end
  
end