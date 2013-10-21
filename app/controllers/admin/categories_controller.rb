class Admin::CategoriesController < ApplicationController
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(params[:category])
    @category.save
    redirect_to new_admin_category_path
  end
  
end