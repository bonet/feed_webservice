class TopicFeed < Feed
  
  attr_accessor :parent_id
  attr_accessible :name, :description, :url, :parent_id
  
  embedded_in :publisher_feed
  embeds_many :subtopic_feeds
  
  validates :parent_id, :presence => true
  
  before_save :set_parent
  
  private
    def set_parent
      
      unless self.parent_id.nil?
        self.publisher_feed = PublisherFeed.find(parent_id)
      end
      
    end
end