class PublisherFeedsController < ApplicationController
  
  def new
    @publisher_feed = PublisherFeed.new
  end
  
  def create

    @publisher_feed = PublisherFeed.new(params[:publisher_feed])
    @publisher_feed.save
    
    redirect_to :action => 'new'
    
  end
end
