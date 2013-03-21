class Category
  
  include Mongoid::Document
  include IdIncrementer # auto increment id
  
  field :_id, type: Integer
  field :name
  
  index({ name: 1 }, { unique: true, name: "idx_category_name" })
  
  attr_accessible :name
  
  has_many :publishers
  
  before_save :populate_id
  
end