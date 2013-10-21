require 'spec_helper'

describe Admin::CategoriesController do
  
  describe "GET 'new'" do

    before { get :new }

    it { response.should be_success }
    it { response.should render_template(:new) }
  end
  
  describe "POST 'create'" do
    before { post :create,  :category => { :name => 'Category A' } }
    
    context "path redirection" do
      it { response.should redirect_to new_admin_category_path }
    end
    
    context "Category creation" do
      it { assigns(:category).should_not be nil }
    end
  end

  
end