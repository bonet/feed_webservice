#
# PubCat Class
#
# Description:
# PubCat is a mixture of Publisher and Category.  One PubCat consists of all relevant XML Feed URLs for one specific Publisher-Category combination.
# For Example, Publisher: NYT + Category: Arts = 1 PubCat. It has one or more Feed URLs and zero or more Content URLs from NYT related to Arts.
# 
# Author: Bonet Sugiarto
# Date: 3/21/2013
#


class PubCat
  
  include Mongoid::Document
  include IdIncrementer # auto increment id
  
  require 'open-uri'
  require 'nokogiri'
  
  MAX_CONTENT_URLS_PER_PUB_CAT = 20
  
  belongs_to :publisher
  belongs_to :category
  
  field :_id, type: Integer
  field :publisher_id, type: Integer
  field :category_id, type: Integer
  field :feed_urls, type: Array
  field :content_urls, type: Hash
  
  has_and_belongs_to_many :pub_cat_aggregates
  
  index({ publisher_id: 1 }, { :name => "idx_publisher_id"})
  index({ category_id: 1 }, { :name => "idx_category_id"})
  
  before_save :populate_id, :split_feed_urls, :populate_content_urls
  
  after_save :update_pub_cat_list
  
  private
  
    def split_feed_urls
      
      self.feed_urls = feed_urls.split(",") if self.feed_urls.is_a? String

    end
    
    def populate_content_urls
      
      self.content_urls = {}
      
      num_feed_urls = self.feed_urls.count
      max_content_urls_per_feed_url = (MAX_CONTENT_URLS_PER_PUB_CAT / num_feed_urls).ceil
      
      self.feed_urls.each do |feed_url|
        
        feed_url.strip!
        
        # Grab the Feed URL 
        response = Nokogiri::XML open(feed_url)
        
        c = 0;
        
        # Parse each content_url item
        response.xpath("//item").each do |s|
          content_url_hash = {}
          
          content_url_hash['title'] = s.at_xpath("title").child().to_s
          content_url_hash['link'] = s.at_xpath("link").child().to_s
          pub_date = Time.parse s.at_xpath("pubDate").child().to_s
          
          unless self.content_urls[pub_date].present?
            self.content_urls[pub_date] = []
          end
          
          # merge (push) all URL items to fc_list_hash
          # it's possible that there is more than 1 item published on the same pub_date, so save each into an array
          self.content_urls[pub_date].push content_url_hash 
          
          break if (c = c+1 ) >= max_content_urls_per_feed_url
          
        end
      end
      
      self.content_urls.keys.sort! unless self.content_urls.nil?
    end
    
    def update_pub_cat_list
      
    end
end