module NewsfeedAggregatePerComponent
  
  def populate_content_urls
    
    newsfeed_id_array = self.newsfeed_ids_string.split(",").sort!
      
    newsfeeds = Newsfeed.where(:_id.in => newsfeed_id_array).and(self.component_id_sym => self.component_id)
    
    # Calculate how many content URLs per Newsfeed we can include to spread the number of content URLs evenly for each Newsfeed
    max_content_urls_per_newsfeed = (Rails.configuration.max_content_urls_per_publisher_or_category / newsfeeds.count).ceil
    
    self.content_urls = {}
    
    newsfeeds.each do |newsfeed|
      
      c_url_hash = {}
      k = 0
      newsfeed.content_urls.each do |key, val|
        
        c_url_hash[key] = val
        
        k = k + 1
        break if k >= max_content_urls_per_newsfeed
      end
      
      self.content_urls.deep_merge!(c_url_hash) unless c_url_hash.nil?
      
    end
    
    self.content_urls.sort_by { |date, urls| date }.reverse!
  end
end