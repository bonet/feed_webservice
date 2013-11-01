require 'spec_helper'

describe NewsfeedAggregate do
  context "Class Attributes" do
    it { should have_and_belong_to_many(:newsfeed_aggregate_per_categories) } 
    it { should have_and_belong_to_many(:newsfeed_aggregate_per_publishers) } 
    
    it { should have_index_for(:newsfeed_ids_string => 1) }
    
    it { should validate_presence_of(:newsfeed_ids_string) }
    
    it { should have_fields(:_id, :newsfeed_ids_string, :updated) }
    
    it { should respond_to(:populate_id) } 
  
  end
  
  context "Object Creation" do
    
    subject(:newsfeed_aggregate) { FactoryGirl.create(:newsfeed_aggregate) }
    
    it "should have correct properties" do
      newsfeed_aggregate.newsfeed_ids_string.should_not be_empty
      newsfeed_aggregate.newsfeed_aggregate_per_publishers.all.count.should be > 0
      newsfeed_aggregate.newsfeed_aggregate_per_categories.all.count.should be > 0
      newsfeed_aggregate.newsfeed_aggregate_per_publishers.all[0].should be_kind_of(NewsfeedAggregatePerPublisher)
      newsfeed_aggregate.newsfeed_aggregate_per_categories.all[0].should be_kind_of(NewsfeedAggregatePerCategory)
    end
  end
  
end