class Admin::PublishersController < ApplicationController
  
  def new
    @publisher = Publisher.new
  end
  
  def create
    @publisher = Publisher.create(params[:publisher])
    redirect_to new_admin_publisher_path
  end
  
end
