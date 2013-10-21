class Admin::PublishersController < ApplicationController
  
  def new
    @publisher = Publisher.new
  end
  
  def create
    @publisher = Publisher.new(params[:publisher])
    @publisher.save
    
    redirect_to new_admin_publisher_path
  end
  
end
