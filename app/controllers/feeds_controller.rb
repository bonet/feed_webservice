class FeedsController < ApplicationController


  def get_feedlist
    
    f = PublisherFeed.all
    render :text => f.to_json
    
  end
  
  def create_feedcollection
    
    #if @fc = FeedCollection.find_by(fc_string: params[:fc_string])
    params[:fc_string] = sanitize_fc_string(sort_comma_separated_string(params[:fc_string]))
 
    @fc = FeedCollection.find_or_create_by( fc_string: params[:fc_string] )
    
    render :text => @fc.errors.full_messages.any? ? @fc.errors.full_messages[0] : @fc.to_json
    
  end
  
  def get_feedcollection 
    fc = FeedCollection.find(params[:id])
    render :text => fc.to_json
  end
  
  
  protected
  
    # Since the order of the comma-separated numeric string input (e.g. '1.2.1,1.2.2,7' vs '1.2.2,1.2.1,7') can be different, 
    # this function is used for sorting such string so that the inner strings are ordered properly.  This is to prevent 
    # duplication of numeric string collections / permutations
    
    def sort_comma_separated_string(fc_string)
      
      arr = []
      
      fc_string.split(",").each do |a|
        b = a.split(".")
        
        if b[0].present? 
          if arr[b[0].to_i].nil?
            arr[b[0].to_i] = [] # initialize array
          end
          
          if b[1].present?
            if arr[b[0].to_i][b[1].to_i].nil?
              arr[b[0].to_i][b[1].to_i] = [] # initialize array
            end
            
            if b[2].present?
              arr[b[0].to_i][b[1].to_i][b[2].to_i] = a
            else
              arr[b[0].to_i][b[1].to_i].push a
            end
              
          else
            arr[b[0].to_i].push [a]
          end
        end
      end
      
      sorted = ""
      
      arr.each do |z|
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
      
      fc_string = sorted.sub!(/,$/, '') #remove trailing ","

    end
    
    # It's possible that the input feed collection doesn't exist in the db due to typo or because the data in db is already changed.  
    # This function checks whether the feed collection input really exists or not.  If they don't exist, they are then removed 
    # from fc_string
    
    def sanitize_fc_string(fc_string)
      
      #url_array = [] # list of feed urls
      
      arr = [] # this array will hold the valid feed collection only. If feed collection doesn't exist in the db, it will be skipped.
               # The final result of arr will be joined and then assigned to the existing 'self.fc_string' as an updated & sanitized value.
      
      # Get content of each RSS feed
      fc_string.split(",").each do |fc|
        
        feed_exists = true # we assume that all feed collection documents exist in db
        
        f = fc.split(".")
        
        
        if f[0].present?
          
          a = PublisherFeed.find(f[0])
          
          if (a.present?) && f[1].present?
            
            b = a.topic_feeds.find(f[1])
            
            if b.present? && f[2].present?
              
              c = b.subtopic_feeds.find(f[2])
              
              if !c.present?
                
                feed_exists = false # this feed collectiondocument doesn't exist in the db
  
              end
              
            elsif !b.present?
              
              feed_exists = false # this feed collection document doesn't exist in the db
              
            end
            
          elsif !a.present?
            
            feed_exists = false # this feed collection document doesn't exist in the db
            
          end
        end
        
        if feed_exists
          arr.push(fc)
        end

      end
      
      #update self.fc_string with only existing feed collection
      fc_string = arr.join(",")

    end

      
end
