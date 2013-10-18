class Newsfeed
  include Mongoid::Document
  include IdIncrementer # auto increment id
  
  require 'open-uri'
  require 'nokogiri'
  
  MAX_CONTENT_URLS_PER_NEWSFEED = 20
  
  belongs_to :publisher
  belongs_to :category
  
  field :_id, type: Integer
  field :publisher_id, type: Integer
  field :category_id, type: Integer
  field :feed_urls, type: Array
  field :content_urls, type: Hash
  field :updated, type: DateTime
  
end