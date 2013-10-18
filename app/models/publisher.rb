class Publisher
  
  include Mongoid::Document
  include IdIncrementer # auto increment id
  
  field :_id, type: Integer
  field :name, type: String

  index({ name: 1 }, { unique: true, name: "idx_publisher_name" })
  
  attr_accessible :name
  
  has_many :newsfeeds, :dependent => :destroy
  
  validates :name, :presence => true, :uniqueness => true, :length => { minimum: 2, maximum: 50 } 
  
  before_save :populate_id
  
end