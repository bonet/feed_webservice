class NewsfeedAggregatePerPublisher
  
  include Mongoid::Document
  include IdIncrementer # auto increment id
  
  field :_id, type: Integer
  field :newsfeed_aggregate_ids, type: Array
  field :newsfeed_ids_string
  field :publisher_id, type: Integer
  field :publisher_name
  field :content_urls, type: Hash
  
  has_and_belongs_to_many :newsfeed_aggregates
  
  before_save :populate_id
  
end