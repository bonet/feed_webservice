class FeedsController < ApplicationController


  def getlist
    
    f = PublisherFeed.all
    render :text => f.to_json
    
  end
  
  def create_combination
    
    @fc = FeedCombination.new(params)
    @fc.save
    
    render :text => @fc.errors.full_messages.any? ? @fc.errors.full_messages[0] : @fc.fc_string
    
  end

      
end
