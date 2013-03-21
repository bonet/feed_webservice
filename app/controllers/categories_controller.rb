class CategoriesController < ApplicationController
  
  def new
    @category = Category.new

  end
  
  def create
    @category = Category.new(params[:category])
    logger.debug "!! " + @category.inspect
    @category.save
    
    redirect_to :action => 'new'
  end
  
end