require 'spec_helper'

describe CategoriesPerPublishersController do

  let(:nyt_tech_feed) { FactoryGirl.create(:nyt_tech_newsfeed) }
  let(:nyt_arts_feed) { FactoryGirl.create(:nyt_arts_newsfeed) }
  let(:wash_business_feed) { FactoryGirl.create(:wash_business_newsfeed) }
  let(:wash_arts_feed) { FactoryGirl.create(:wash_arts_newsfeed) }
  
  before(:each) do
    nyt_tech_feed
    nyt_arts_feed
    wash_business_feed
    wash_arts_feed
    CategoriesPerPublisher.cron_update_categories_per_publisher
  end
  
  describe "GET 'show'" do
    
    before do 
      get :show
    end
    
    it { response.should be_success }
    
    it "should return the correct response" do
      publisher_ids_array = [ nyt_tech_feed.publisher_id, wash_business_feed.publisher_id ]
      category_ids_array = [ nyt_tech_feed.category_id, nyt_arts_feed.category_id, wash_business_feed.category_id ]
      
      json_publisher_ids_array = []
      json_category_ids_array = []
      
      json = JSON.parse(response.body)
      json.should_not be_nil
      json.count.should eq 2
      json.each do |item| 
        publisher_ids_array.should include item[1]["publisher_id"] 
        json_publisher_ids_array << item[1]["publisher_id"] 
        item[1]["categories"].each do |item2|
          category_ids_array.should include item2["category_id"]
          json_category_ids_array << item2["category_id"]
        end
      end
      json_publisher_ids_array.uniq.count.should eql publisher_ids_array.count
      json_category_ids_array.uniq.count.should eql category_ids_array.count
    end
  end
  
  describe "GET 'show_personalized'" do
    
    # CategoriesPerPublisher is personalized to only show the following newsfeeds: wash_business_feed._id, wash_arts_feed._id, and nyt_arts_feed._id
    
    let(:newsfeed_aggregate) { NewsfeedAggregate.create( :newsfeed_ids_string => [ wash_business_feed._id, wash_arts_feed._id, nyt_arts_feed._id ].join(",") ) }
    
    before do
      newsfeed_aggregate
      get :show_personalized, :newsfeed_aggregate_id => newsfeed_aggregate._id
    end
    
    it { response.should be_success }
    
    it "should return the correct response" do
      
      publisher_ids_array = [ wash_business_feed.publisher_id, nyt_arts_feed.publisher_id ]
      category_ids_array = [ wash_business_feed.category_id, wash_arts_feed.category_id ]
      
      json_publisher_ids_array = []
      json_category_ids_array = []
      
      json = JSON.parse(response.body)
      json.should_not be_nil
      json.count.should eq 2
      json.each do |item| 
        publisher_owned = false
        
        item[1]["categories"].each do |item2|
          if item2["owned"] == "true"
            category_ids_array.should include item2["category_id"]
            json_category_ids_array << item2["category_id"]
            publisher_owned = true
          end
        end
        
        if publisher_owned == true
          publisher_ids_array.should include item[1]["publisher_id"] 
          json_publisher_ids_array << item[1]["publisher_id"] 
        end
      end
      json_publisher_ids_array.uniq.count.should eql publisher_ids_array.count
      json_category_ids_array.uniq.count.should eql category_ids_array.count

    end
  end
end