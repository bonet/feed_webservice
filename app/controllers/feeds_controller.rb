class FeedsController < ApplicationController
  
  def index
    PublisherFeed.all.each do |p|
      logger.debug " +++ " + p.inspect
    end
    
  end
  
  def new 
    @feed_id_array = [["", nil]]
    @feed = Feed.new
    Feed.all.each do |f|
      @feed_id_array <<  [ f.name, f._id ]
    end
    #logger.debug "FEED ID ARR IS : " + @feed_id_array.inspect
  end
  
  def show
    @feed = Feed.find(params[:id])
  end
  
  def create
    @feed = Feed.new(params[:feed])
    
    if @feed.save

      logger.debug "+1+" + params[:feed][:parent_id].inspect
      logger.debug "+2+" + @feed.inspect
      set_parent(params)
      redirect_to @feed
    else
      render 'new'
    end
  end
  
  private
      def set_parent(params)
      
        unless params[:feed][:parent_id].nil?
          f = Feed.find(params[:feed][:parent_id])
          g = Feed.find(params[:feed][:parent_id])
          
          unless f.nil?
            logger.debug "?!! @feed: " + @feed.inspect
            logger.debug "?!! @feed_metadata: " + @feed.metadata.inspect
            logger.debug "?!! g.child_feeds: " + g.to_json.inspect
            logger.debug "?!! g_metadata: " + g.metadata.inspect
            f.child_feeds.push(g)
            

          end
        end
      end
end
