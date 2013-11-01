require 'spec_helper'

describe NewsfeedAggregatePerPublisher do
  
  context "Class Attributes" do
    it { should have_and_belong_to_many(:newsfeed_aggregates) } 
    it { should respond_to(:populate_id, :populate_content_urls) } 
    it { should have_fields(:_id, :newsfeed_aggregate_ids, :newsfeed_ids_string, :publisher_id, :publisher_name, :content_urls) }
  end
  
  context "Object Creation" do
    
    let(:newsfeed_aggregate_nyt) { FactoryGirl.create(:newsfeed_aggregate_per_publisher_nyt) }
    
    it "should have correct attributes" do
      newsfeed_aggregate_nyt.content_urls.should_not be_empty 
      newsfeed_aggregate_nyt.newsfeed_ids_string.should_not be_empty
      newsfeed_aggregate_nyt.publisher_id.should eql(get_publisher(:publisher_nyt)._id)
      newsfeed_aggregate_nyt.publisher_name.should eql(get_publisher(:publisher_nyt).name)
    end
  end
end