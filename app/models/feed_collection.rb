class FeedCollection
  
  include Mongoid::Document
  include IdIncrementer # auto increment id
  
  require 'open-uri'
  require 'nokogiri'
  
  MAX_ITEM_PER_FEED = 5
  
  field :_id, type: Integer
  field :fc_string
  field :feed_collection_list, type: Moped::BSON::ObjectId
  
  embeds_one :feed_collection_list
  
  attr_accessible :fc_string
  
  #before_validation :sort_comma_separated_string
  
  validates :fc_string, :presence => true, :length => { :minimum => 1}#, :uniqueness => true
  
  before_save :populate_id, :aggregate_fc_list


  
  private
  

    def aggregate_fc_list
      
      fc_list_hash = {}
      
      # get XML RSS feed URLs
      url_array = get_feed_url_array
      
=begin
      if @@s3.nil?
        @@s3 = AWS::S3.new 
        @@bucket = @@s3.buckets[ENV['AWS_BUCKET']]
      end
=end
      
      #get the URL items form the RSS and save+sort them into 'fc_list_hash' 
      url_array.each do |url|
        response = Nokogiri::XML open(url)
        
        c = 0;
        
        response.xpath("//item").each do |s|
          item_hash = {}
          
          item_hash['title'] = s.at_xpath("title").child().to_s
          item_hash['link'] = s.at_xpath("link").child().to_s
          pub_date = Time.parse s.at_xpath("pubDate").child().to_s
          
          unless fc_list_hash[pub_date].present?
            fc_list_hash[pub_date] = []
          end
          
          # merge (push) all URL items to fc_list_hash
          # it's possible that there is more than 1 item published on the same pub_date, so save each into an array
          fc_list_hash[pub_date].push item_hash 
          
          break if (c = c+1 ) >= MAX_ITEM_PER_FEED
          
        end
        
        
      end
      
      # sort the feed collection list by the latest first
      fc_list_hash = fc_list_hash.sort_by { |k,v| k }.reverse 
      
      # set feed_collection_list ('has_one' relation)
      self.feed_collection_list = FeedCollectionList.new( list: fc_list_hash )
      
      #logger.debug(fc_list_hash)
      
      #fc_list_hash.each do |k,v|
      #  logger.debug "====  "+ k.inspect + "===FC_HASH: " + v.class.inspect
      #  logger.debug "....... \n\n"
      #end
      
    end
    
    
    # get an array of feed URLs from each feed included in self.fc_string
    def get_feed_url_array
      
      url_array = [] # list of feed urls
      
      self.fc_string.split(",").each do |fc|
        
        f = fc.split(".")
        
        if f[0].present?
          a = PublisherFeed.find(f[0])
          
          if a.present? && f[1].present?
            
            b = a.topic_feeds.find(f[1])
            
            if b.present? && f[2].present?
              
              c = b.subtopic_feeds.find(f[2])
              
              if c.present? && !c.url.nil?
                url_array << c.url
              end
              
            elsif b.present? && !b.url.nil?
              
              url_array << b.url
              
            end
          end
        end
      end
      
      return url_array
    end  
      
      

    
    
    
    
  
end