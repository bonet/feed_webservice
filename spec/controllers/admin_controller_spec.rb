require 'spec_helper'

describe AdminController do
  
  describe "GET 'index'" do
    before do
      get :index
    end
    
    it { response.should be_success }
    it { response.should render_template(:index) }
  end
end