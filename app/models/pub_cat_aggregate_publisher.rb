#
# PubCatAggregatePublisher Class
#
# Description:
# PubCatAggregatePublisher is an aggregate of PubCats grouped by publisher.  This is to falicitate filtering URL Contents by Publisher.
#
# Author: Bonet Sugiarto
# Date: 3/21/2013
#

class PubCatAggregatePublisher
  
  include Mongoid::Document
  include IdIncrementer # auto increment id
  
  field :_id, type: Integer
  field :pub_cat_aggregate_ids, type: Array
  field :pub_cat_ids_string
  field :publisher_id, type: Integer
  field :publisher_name
  field :content_urls, type: Hash
  
  has_and_belongs_to_many :pub_cat_aggregates
  
  before_save :populate_id
  
end