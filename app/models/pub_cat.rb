class PubCat
  
  include Mongoid::Document
  include IdIncrementer # auto increment id
  
  require 'open-uri'
  require 'nokogiri'
  
  #require 'active_support/core_ext/hash/deep_merge'
  
  MAX_CONTENT_URLS_PER_FEED_URL = 2
  
  belongs_to :publisher
  belongs_to :category
  
  field :_id, type: Integer
  field :publisher_id, type: Integer
  field :category_id, type: Integer
  field :feed_urls, type: Array
  field :content_urls, type: Hash
  
  has_and_belongs_to_many :pub_cat_aggregates
  
  #index({ publisher_id: 1, category_id: 1 }, { unique: true, :name => "idx_publisher_id_category_id"})
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
      
      self.feed_urls.each do |feed_url|
        
        feed_url.strip!
        
        response = Nokogiri::XML open(feed_url)
        
        c = 0;
        
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
          
          break if (c = c+1 ) >= MAX_CONTENT_URLS_PER_FEED_URL
          
        end
      end
    end
    
    def update_pub_cat_list
      
    end
end