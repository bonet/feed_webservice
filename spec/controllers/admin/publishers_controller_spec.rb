require 'spec_helper'

describe Admin::PublishersController do
  
  describe "GET 'new'" do

    before { get :new }

    it { response.should be_success }
    it { response.should render_template(:new) }
  end
  
  describe "POST 'create'" do
    before { post :create,  :publisher => { :name => 'Publisher X' } }
    
    context "path redirection" do
      it { response.should redirect_to new_admin_publisher_path }
    end
    
    context "Publisher creation" do
      it { assigns(:publisher).should_not be nil }
    end
  end

  
end