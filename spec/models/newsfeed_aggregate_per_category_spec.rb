require 'spec_helper'

describe NewsfeedAggregatePerCategory do
  
  it { should have_and_belong_to_many(:newsfeed_aggregates) } 
  it { should respond_to(:populate_id, :populate_content_urls) } 
  it { should have_fields(:_id, :newsfeed_aggregate_ids, :newsfeed_ids_string, :category_id, :category_name, :content_urls) }
  
  context "object creation" do
    
    let(:newsfeed_aggregate_art) { FactoryGirl.create(:newsfeed_aggregate_per_category_art) }
    
    it "should have correct attributes" do
      newsfeed_aggregate_art.content_urls.should_not be_empty
      newsfeed_aggregate_art.newsfeed_ids_string.should_not be_empty
      newsfeed_aggregate_art.category_id.should eql(get_category(:category_art)._id)
      newsfeed_aggregate_art.category_name.should eql(get_category(:category_art).name)
    end
  end
end