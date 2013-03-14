class SubtopicFeed < Feed
  
  attr_accessor :parent_id
  attr_accessible :name, :description, :url, :parent_id
  
  embedded_in :topic_feed
  
  validate :publisher_feed_and_topic_feed_must_exist
  validates :name, presence: true
  
  before_save :set_parent
  
  private
  
    def set_parent
      if(@parent_id_array[0].present? && @parent_id_array[1].present?)
          self.topic_feed = PublisherFeed.find(@parent_id_array[0]).topic_feeds.find(@parent_id_array[1])
      end
    end
    
    def publisher_feed_and_topic_feed_must_exist
      if self.parent_id.present? 
        @parent_id_array = self.parent_id.split('.')
      
        if(@parent_id_array[0].nil? || @parent_id_array[1].nil?)
          errors.add(:parent_id, " is not valid")
          logger.debug "!!>>>>>>>PARENT ID INVALID"
        end
      else
        logger.debug "!!>>>>>>>PARENT ID NOT EXISTS"
        errors.add(:parent_id, " is empty")
      end
    end
end