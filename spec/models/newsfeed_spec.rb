require 'spec_helper'

describe Newsfeed do
  
  context "Class Attributes" do
    it { should belong_to(:category) } 
    it { should belong_to(:publisher) } 
    
    it { should have_fields(:_id, :category_id, :publisher_id, :feed_urls, :content_urls, :updated) }
    
    [:publisher_id, :category_id, :feed_urls, :content_urls].each do |attribute|
      it { should allow_mass_assignment_of(attribute) }
    end
    
    it { should have_index_for(:publisher_id => 1) }
    it { should have_index_for(:category_id => 1) }
    
    it { should validate_presence_of(:publisher_id) }
    it { should validate_numericality_of(:publisher_id).to_allow(:only_integer => true, :greater_than => 0) }
    
    it { should validate_presence_of(:category_id) }
    it { should validate_numericality_of(:category_id).to_allow(:only_integer => true, :greater_than => 0) }
  end
  
  context "Object Creation" do
    
    let(:nyt_tech_feed) { FactoryGirl.create(:nyt_tech_newsfeed) }
    
    it "should have proper attributes" do
      nyt_tech_feed.should_not be_nil
      nyt_tech_feed.content_urls.count.should be > 0
      nyt_tech_feed.feed_urls.count.should eql(3)
    end
    
    it ":_id should increment by 1" do
      
      nyt_tech_feed
      
      lambda {
        FactoryGirl.create(:nyt_arts_newsfeed) 
      }.should change{ Newsfeed.max(:_id) }.by(1)
    end
  end
end