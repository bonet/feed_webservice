class Feed
  
  include Mongoid::Document
  include IdIncrementer # auto increment id

  field :_id, type: Integer
  field :name
  field :description
  field :url
  
=begin
  field :name
  field :url
  
  recursively_embeds_many
  
  
  attr_accessor :parent_id
  attr_accessible :url, :name, :parent_id
  
  
=end

  before_save :populate_id


end
