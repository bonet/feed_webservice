require 'spec_helper'

describe Admin::NewsfeedsController do
  
  before do 
    FactoryGirl.create_list(:category, 2)
    FactoryGirl.create_list(:publisher, 3)
  end
  
  describe "GET 'new'" do

    before do 
      get :new
    end

    it { response.should be_success }
    it { response.should render_template(:new) }
    
    it { assigns(:newsfeed).should_not be nil }
    it { assigns(:category_array).count.should be == 2 }
    it { assigns(:publisher_array).count.should be == 3 }
    
  end

  describe "POST 'create'" do
    
    before do 
      post :create,  :newsfeed => { :category_id => 2, 
                                    :publisher_id => 1, 
                                    :feed_urls => "http://rss.nytimes.com/services/xml/rss/nyt/Technology.xml, http://rss.nytimes.com/services/xml/rss/nyt/Science.xml"
                                  }
    end
    
    context "path redirection" do
      it { response.should redirect_to new_admin_newsfeed_path }
    end
    
    context "Newsfeed object creation" do
      it "total Newsfeed item count should be 1" do
        Newsfeed.count.should eq(1)
      end
      
      it "category_id should be 2" do 
        assigns(:newsfeed).category_id.should eq(2)
      end
      
      it "publisher_id should be 1" do 
        assigns(:newsfeed).publisher_id.should eq(1)
      end
      
      it "feed_urls count should be 2" do 
        assigns(:newsfeed).feed_urls.count.should eq(2)
      end
    end
  end
  
end