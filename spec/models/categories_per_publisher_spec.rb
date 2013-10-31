require 'spec_helper'

describe CategoriesPerPublisher do
  
  context "Class definition" do
    it { CategoriesPerPublisher.should respond_to(:cron_update_categories_per_publisher) } 
  end
  
  context "Cron test" do
    
    before do
      FactoryGirl.create(:nyt_tech_newsfeed)
      FactoryGirl.create(:nyt_arts_newsfeed)
      CategoriesPerPublisher.cron_update_categories_per_publisher
    end
    
    it "should create Categories per Publisher list" do
      CategoriesPerPublisher.count.should eql(1)
    end
    
    it "should have a complete namelist" do
      cats_per_publisher = CategoriesPerPublisher.first.namelist["2"]
      
      cats_per_publisher.should_not be_empty
      cats_per_publisher["publisher_id"].should be > 0
      cats_per_publisher["publisher_name"].should_not be_empty
      cats_per_publisher["categories"][0]["newsfeed_id"].should be > 0
      cats_per_publisher["categories"][0]["category_id"].should be > 0
      cats_per_publisher["categories"][0]["category_name"].should_not be_empty
    end
  end
end