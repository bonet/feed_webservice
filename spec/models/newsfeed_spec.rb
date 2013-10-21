require 'spec_helper'

describe Newsfeed do
  it { should belong_to(:category) } 
  it { should belong_to(:publisher) } 
  
  it { should have_fields(:_id, :category_id, :publisher_id, :feed_urls, :content_urls, :updated) }
  it { should have_index_for(:publisher_id => 1) }
  it { should have_index_for(:category_id => 1) }
  
  it { should validate_presence_of(:publisher_id) }
  it { should validate_numericality_of(:publisher_id).to_allow(:only_integer => true, :greater_than => 0) }
end