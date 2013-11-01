require 'spec_helper'

describe NewsfeedAggregatesController do
   
  let(:nyt_tech_feed) { FactoryGirl.create(:nyt_tech_newsfeed) }
  let(:nyt_arts_feed) { FactoryGirl.create(:nyt_arts_newsfeed) }
  let(:wash_business_feed) { FactoryGirl.create(:wash_business_newsfeed) }
  let(:wash_arts_feed) { FactoryGirl.create(:wash_arts_newsfeed) }
  
  before(:each) do
    nyt_tech_feed
    nyt_arts_feed
    wash_business_feed
    wash_arts_feed
    post :create, { :newsfeed_ids => "#{wash_arts_feed._id},#{nyt_tech_feed._id},#{nyt_arts_feed._id}" }
  end
  
  describe "POST 'create'" do
    
    it "should create NewsfeedAggregate" do
      NewsfeedAggregate.first.should_not be_nil
      NewsfeedAggregate.first.newsfeed_ids_string.should eql "#{nyt_tech_feed._id},#{nyt_arts_feed._id},#{wash_arts_feed._id}" # order has to be identical (ascending)
      NewsfeedAggregate.first.newsfeed_aggregate_per_publisher_ids.should =~ [nyt_tech_feed.publisher_id, wash_arts_feed.publisher_id]
      NewsfeedAggregate.first.newsfeed_aggregate_per_category_ids.should =~ [nyt_arts_feed.category_id, nyt_tech_feed.category_id]
      NewsfeedAggregate.first.newsfeed_aggregate_per_publishers.count.should eql 2
      NewsfeedAggregate.first.newsfeed_aggregate_per_categories.count.should eql 2
    end
    
  end
  
  describe "GET 'show'" do
    
    let(:newsfeed_aggregate_id) { NewsfeedAggregate.first._id }
    before do
      get :show, :id => newsfeed_aggregate_id
    end
    
    it { response.should be_success }
    it "should retrieve the correct NewsfeedAggregate in response body" do
      json = JSON.parse(response.body)
      
      json.should_not be_nil
      json["_id"].should eql newsfeed_aggregate_id
      json["newsfeed_ids_string"].should eql "#{nyt_tech_feed._id},#{nyt_arts_feed._id},#{wash_arts_feed._id}" # order has to be identical (ascending)
      json["newsfeed_aggregate_per_publisher_ids"].should =~ [nyt_tech_feed.publisher_id, wash_arts_feed.publisher_id]
      json["newsfeed_aggregate_per_category_ids"].should =~ [nyt_arts_feed.category_id, nyt_tech_feed.category_id]
      json["newsfeed_aggregate_per_publishers"].count.should eql 2
      json["newsfeed_aggregate_per_categories"].count.should eql 2
    end
  end
  
  describe "GET 'show_default'" do
    
    before do
      get :show_default
    end
    
    it { response.should be_success }
    it "should retrieve the correct NewsfeedAggregate in response body" do
      json = JSON.parse(response.body)
      
      json.should_not be_nil
      json["_id"].should eql Rails.configuration.default_newsfeed_aggregate_id
      json["newsfeed_ids_string"].should eql "#{nyt_tech_feed._id},#{nyt_arts_feed._id},#{wash_arts_feed._id}"  # order has to be identical (ascending)
      json["newsfeed_aggregate_per_publisher_ids"].should =~ [nyt_tech_feed.publisher_id, wash_arts_feed.publisher_id]
      json["newsfeed_aggregate_per_category_ids"].should =~ [nyt_arts_feed.category_id, nyt_tech_feed.category_id]
      json["newsfeed_aggregate_per_publishers"].count.should eql 2
      json["newsfeed_aggregate_per_categories"].count.should eql 2
    end
  end
end