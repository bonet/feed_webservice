class PublisherFeed < Feed
  
  embeds_many :topic_feeds
  
  #before_save :parent_populate_id
end