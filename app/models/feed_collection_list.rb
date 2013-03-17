class FeedCollectionList
  
  include Mongoid::Document
  
  field :list

  attr_accessible :list
  
  embedded_in :feed_collection
  
  
end