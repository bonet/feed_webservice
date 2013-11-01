require 'spec_helper'

describe CategoriesPerPublisher do
  
  context "Class attributes" do
    it { CategoriesPerPublisher.should respond_to(:cron_update_categories_per_publisher) } 
    it { should have_fields(:namelist) }
  end
  
  context "cron_update_categories_per_publisher test" do
    let(:nyt_tech_feed) { FactoryGirl.create(:nyt_tech_newsfeed) }
    let(:nyt_arts_feed) { FactoryGirl.create(:nyt_arts_newsfeed) }
    let(:wash_arts_feed) { FactoryGirl.create(:wash_arts_newsfeed) }
    let(:wash_business_feed) { FactoryGirl.create(:wash_business_newsfeed) }
    
    before do
      nyt_tech_feed
      nyt_arts_feed
      CategoriesPerPublisher.cron_update_categories_per_publisher
    end
    
    it "should create Categories per Publisher list" do
      CategoriesPerPublisher.count.should eql(1)
    end
    
    it "should have a complete namelist" do
      cats_per_publisher = CategoriesPerPublisher.first.namelist["1"]
      
      cats_per_publisher.should_not be_empty
      cats_per_publisher["publisher_id"].should eql nyt_tech_feed.publisher_id
      cats_per_publisher["publisher_name"].should_not be_empty
      
      [nyt_tech_feed._id, nyt_arts_feed._id].should include cats_per_publisher["categories"][0]["newsfeed_id"]
      [nyt_tech_feed.category_id, nyt_arts_feed.category_id].should include cats_per_publisher["categories"][0]["category_id"]
      
      cats_per_publisher["categories"][0]["category_name"].should_not be_empty
    end
    
    it "should update the namelist upon creation of new newsfeed" do
      
      wash_arts_feed
      wash_business_feed
      
      CategoriesPerPublisher.cron_update_categories_per_publisher # run cron update again
      
      cats_per_publisher = CategoriesPerPublisher.first.namelist["2"]
      
      cats_per_publisher.should_not be_empty
      cats_per_publisher["publisher_id"].should eql wash_arts_feed.publisher_id
      cats_per_publisher["publisher_name"].should_not be_empty
      
      [wash_arts_feed._id, wash_business_feed._id].should include cats_per_publisher["categories"][0]["newsfeed_id"]
      [wash_arts_feed.category_id, wash_business_feed.category_id].should include cats_per_publisher["categories"][0]["category_id"]
      
      cats_per_publisher["categories"][0]["category_name"].should_not be_empty
    end
  end
end