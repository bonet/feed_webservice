class FeedCombination
  
  include Mongoid::Document
  include IdIncrementer # auto increment id
  
  field :_id, type: Integer
  field :fc_string
  field :fc_url
  
  attr_accessible :fc_string, :fc_url
  
  before_validation :sort_comma_separated_string
  
  validates :fc_string, :presence => true, :length => { :minimum => 1}#, :uniqueness => true
  
  before_save :create_sorted_feed_list, :populate_id

  private

    def create_sorted_feed_list
      
      # get all feed urls
      urls = get_feed_urls_and_sanitize_feed_combinations_string
      
      logger.debug "---------- " + urls.inspect
      
      # retrieve all RSS feed contents from the URLS
      
      # Merge and sort the contents by created_date
      
      # Upload the merged contents to S3
      
      # :fc_url = URL of S3 document
      
    end
      
      
    def get_feed_urls_and_sanitize_feed_combinations_string
      
      url_array = [] # list of feed urls
      
      arr = [] # this array will hold the valid feed combination only. If feed combination doesn't exist in the db, it will be skipped.
               # The final result of arr will be joined and then assigned to the existing 'self.fc_string' as an updated & sanitized value.
      
      # Get content of each RSS feed
      self.fc_string.split(",").each do |fc|
        
        feed_exists = true # we assume that all feed combination documents exist in db
        
        f = fc.split(".")
        
        if f[0].present? && PublisherFeed.find(f[0]).present?
          
          if f[1].present? && PublisherFeed.find(f[0]).topic_feeds.find(f[1]).present?
            
            if f[2].present? && PublisherFeed.find(f[0]).topic_feeds.find(f[1]).subtopic_feeds.find(f[2]).present?
              
              u = PublisherFeed.find(f[0]).topic_feeds.find(f[1]).subtopic_feeds.find(f[2]).url
              
              unless u.blank?
                url_array << u
              end
              
            elsif f[2].present?
              
              feed_exists = false # this feed combination document doesn't exist int the db
              
            else
              
              u = PublisherFeed.find(f[0]).topic_feeds.find(f[1]).url
              
              unless u.blank?
                url_array << u
              end 
              
            end
          elsif f[1].present?
            
            feed_exists = false # this feed combination document doesn't exist int the db
            
          end
        elsif f[0].present?
          
          feed_exists = false # this feed combination document doesn't exist int the db
          
        end
        
        if feed_exists
          arr.push(fc)
        end

      end
      
      #update self.fc_string with only existing feed combination
      self.fc_string = arr.join(",")
      
      return url_array
    end
    
    
    
    # Since the order of the comma-separated numeric string input (e.g. '1.2.1,1.2.2,7' vs '1.2.2,1.2.1,7') can be different, 
    # this function can be used to sort such string so that the inner strings are ordered properly.  This is to prevent 
    # duplication of numeric string combinations / permutations
    
    def sort_comma_separated_string
      
      #str example: "1.2.2,8,1.1.2,10.3,1.2.5,2.1.1,1.2.1"
      
      temp_X = []
      temp_Y = []
      temp_Z = []
  
      # 'sort' 1st number element into array
      self.fc_string.split(",").each do |a|
        
        b = a.split(".")
        
        if temp_X[b[0].to_i].nil?
          temp_X[b[0].to_i] = [] # initialize array
        end
        
        temp_X[b[0].to_i].push(a)
        
      end
      
      #temp_X example result: [nil, ["1.2.2", "1.1.2", "1.2.5", "1.2.1"], ["2.1.1"], nil, nil, nil, nil, nil, ["8"], nil, ["10.3"]]
      
      
      # 'sort' 2nd number element into array
      temp_X.each_with_index do |v,k|
        
        unless v.nil?
          
          if temp_Y[k.to_i].nil?
              temp_Y[k.to_i] = [] # initialize array
          end
          
          v.each do |c|
            
            d = c.split(".")
            
            if d[1].present?
              if temp_Y[k.to_i][d[1].to_i].nil?
                temp_Y[k.to_i][d[1].to_i] = [] # initialize array
              end
              temp_Y[k.to_i][d[1].to_i].push(c)
            else
              temp_Y[k.to_i].push([c])
            end
            
            
          end
        end
      end
      
      #temp_Y example result: [nil, [nil, ["1.1.2"], ["1.2.2", "1.2.5", "1.2.1"]], [nil, ["2.1.1"]], nil, nil, nil, nil, nil, [["8"]], nil, [nil, nil, nil, ["10.3"]]]
      
      
      # 'sort' 3rd number element into array
      temp_Y.each_with_index do |v,k|
        unless v.nil?
          
          if temp_Z[k.to_i].nil?
              temp_Z[k.to_i] = [] # initialize array
          end
          
          v.each_with_index do |j,i|
            unless j.nil?
              
              if temp_Z[k.to_i][i.to_i].nil?
                temp_Z[k.to_i][i.to_i] = [] # initialize array
              end
              
              j.each do |r|
                q = r.split(".")
                temp_Z[k.to_i][i.to_i][q[2].to_i] = r
              end
            end
          end
        end
      end
      
      #temp_Z example result: [nil, [nil, [nil, nil, "1.1.2"], [nil, "1.2.1", "1.2.2", nil, nil, "1.2.5"]], [nil, [nil, "2.1.1"]], nil, nil, nil, nil, nil, [["8"]], nil, [nil, nil, nil, ["10.3"]]]
      
      
      sorted = ""
      
      #transfer the already sorted array into 'sorted' string
      temp_Z.each do |z|
        unless z.nil?
          z.each do |y|
            unless y.nil?
              y.each do |x|
                unless x.nil?
                 sorted += x + ","
                end
              end
            end
          end
        end
      end
      
      self.fc_string = sorted.sub!(/,$/, '') #remove trailing ","
      
      #'sorted' example result: "1.1.2,1.2.1,1.2.2,1.2.5,2.1.1,8,10.3"
      
    end
  
end