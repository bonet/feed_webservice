#
# Publisher Class
#
# Description:
# One Publisher object holds information (as of now, it's only 'name') about one unique Publisher 
# 
# Author: Bonet Sugiarto
# Date: 3/21/2013
#


class Publisher
  
  include Mongoid::Document
  include IdIncrementer # auto increment id
  
  field :_id, type: Integer
  field :name

  index({ name: 1 }, { unique: true, name: "idx_publisher_name" })
  
  attr_accessible :name
  
  has_many :categories
  
  before_save :populate_id
  
end