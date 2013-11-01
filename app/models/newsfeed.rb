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
  
  index({ publisher_id: 1 }, { :name => "idx_publisher_id"})
  index({ category_id: 1 }, { :name => "idx_category_id"})
  
  attr_accessible :publisher_id, :category_id, :feed_urls, :content_urls
  
  validates :publisher_id, :presence => true, :numericality => { greater_than: 0, only_integer: true }
  validates :category_id, :presence => true, :numericality => { greater_than: 0, only_integer: true }
  validates :feed_urls, :presence => true
  
  before_save :populate_id, :split_feed_urls, :populate_content_urls


  private
  
  def split_feed_urls
    self.feed_urls = feed_urls.split(",") if self.feed_urls.is_a? String
  end
  
  def populate_content_urls
    
    self.content_urls = {}
    
    num_feed_urls = self.feed_urls.count
    max_content_urls_per_feed_url = (MAX_CONTENT_URLS_PER_NEWSFEED / num_feed_urls).ceil
    
    self.feed_urls.each do |feed_url|
      
      feed_url.strip!
      
      # Grab the Feed URL 
      response = Nokogiri::XML open(feed_url)
      
      c = 0
      
      # Parse each content_url item
      response.xpath("//item").each do |u|
        content_url_hash = {}
        
        content_url_hash['title'] = u.at_xpath("title").child().to_s
        content_url_hash['link'] = u.at_xpath("link").child().to_s
        pub_date = DateTime.parse u.at_xpath("pubDate").child().to_s
        
        unless self.content_urls[pub_date].present?
          self.content_urls[pub_date] = []
        end
        
        # it's possible that there is more than 1 item published on the same pub_date, so push each into the pub_date-indexed array
        self.content_urls[pub_date].push content_url_hash 
        
        break if (c += 1 ) >= max_content_urls_per_feed_url
        
      end
    end
    
    self.content_urls.sort_by { |date, urls| date }.reverse! unless self.content_urls.nil?
    
    self.updated = DateTime.now
  end
end