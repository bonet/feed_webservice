class NewsfeedAggregatePerCategory
  
  include Mongoid::Document
  include IdIncrementer 
  include NewsfeedAggregatePerComponent
  
  field :_id, type: Integer
  field :newsfeed_aggregate_ids, type: Array
  field :newsfeed_ids_string
  field :category_id, type: Integer
  field :category_name
  field :content_urls, type: Hash
  
  has_and_belongs_to_many :newsfeed_aggregates
  
  before_save :populate_id, :populate_content_urls
  
  def component_id_sym
    :category_id
  end
  
  def component_id
    self.category_id
  end

end