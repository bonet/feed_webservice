class NewsfeedAggregatePerPublisher
  
  include Mongoid::Document
  include IdIncrementer
  include NewsfeedAggregatePerComponent
  
  field :_id, type: Integer
  field :newsfeed_aggregate_ids, type: Array
  field :newsfeed_ids_string
  field :publisher_id, type: Integer
  field :publisher_name
  field :content_urls, type: Hash
  
  has_and_belongs_to_many :newsfeed_aggregates
  
  before_save :populate_id, :populate_content_urls
  
  def component_id_sym
    :publisher_id
  end
  
  def component_id
    self.publisher_id
  end
  
end