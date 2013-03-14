class SubtopicFeedsController < ApplicationController
    def new
    @subtopic_feed = SubtopicFeed.new
    
    #top empty value for select option
    @topic_feed_id_array = [["", nil]]

    #create array for select options in the format: ["Publisher Feed Name - Topic Feed Name", "<publisher_feed_id>.<topic_feed_id>"]
    PublisherFeed.all.each do |f|
      
      f.topic_feeds.each do |t|
        a = f.name + ' - ' + t.name
        b = f._id.to_s + '.' + t._id.to_s
        @topic_feed_id_array << [ a, b ]
      end 
    end
  end
  
  def create
    
    @subtopic_feed = SubtopicFeed.new(params[:subtopic_feed])
    @subtopic_feed.save
    
    redirect_to :action => 'new'
  end
end
