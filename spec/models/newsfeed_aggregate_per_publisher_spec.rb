require 'spec_helper'

describe NewsfeedAggregatePerPublisher do
  
  it { should have_and_belong_to_many(:newsfeed_aggregates) } 
  it { should respond_to(:populate_id) } 
  it { should have_fields(:_id, :newsfeed_aggregate_ids, :newsfeed_ids_string, :publisher_id, :publisher_name, :content_urls) }
  
end