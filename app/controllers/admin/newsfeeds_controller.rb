class Admin::NewsfeedsController < ApplicationController
  
  def new
    
    @newsfeed = Newsfeed.new
    
    @publisher_array = Publisher.all.map { |publisher| [ publisher.name, publisher._id ] }
    
    @category_array = Category.all.map { |category| [ category.name, category._id ] }
    
    #@newsfeed_array = Newsfeed.all.map do |newsfeed|
    #  { :_id => newsfeed.id.to_s, :publisher => Publisher.find(newsfeed.publisher_id)._id.to_s, :category => Category.find(newsfeed.category_id)._id.to_s  }
    #end
    
  end
  
  def create
    @newsfeed = Newsfeed.create(params[:newsfeed])
    redirect_to new_admin_newsfeed_path
  end
  
end