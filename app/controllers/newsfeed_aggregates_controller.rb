class NewsfeedAggregatesController < ApplicationController
  
  def show
    newsfeed_aggregate = NewsfeedAggregate.find(params[:id])
    render :text => newsfeed_aggregate.to_json
  end
  
  
  def show_default
    newsfeed_aggregate = NewsfeedAggregate.find(Rails.configuration.default_newsfeed_aggregate_id)
    render :text => newsfeed_aggregate.to_json
  end
  
  
  def create
    newsfeed_aggregate = NewsfeedAggregate.where(:newsfeed_ids_string => params[:newsfeed_ids].split(",").uniq.sort!.join(",")).first
      
    unless newsfeed_aggregate.present?
      newsfeed_aggregate = NewsfeedAggregate.create(:newsfeed_ids_string => params[:newsfeed_ids])
    end

    render :text => newsfeed_aggregate.to_json
  end

end