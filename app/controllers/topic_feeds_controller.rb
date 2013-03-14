class TopicFeedsController < ApplicationController
  def new
    @topic_feed = TopicFeed.new
    
    @publisher_feed_id_array = [["", nil]]

    PublisherFeed.all.each do |f|
      @publisher_feed_id_array <<  [ f.name, f._id ]
    end
  end
  
  def create
    @topic_feed = TopicFeed.new(params[:topic_feed])
    @topic_feed.save
    
    redirect_to :action => 'new'
  end
end
