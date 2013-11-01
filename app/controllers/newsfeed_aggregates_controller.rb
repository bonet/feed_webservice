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
    sorted_newsfeed_id_string = self.sort_numeric_csv_string(params[:newsfeed_ids]) 

    newsfeed_aggregate = NewsfeedAggregate.where(:newsfeed_ids_string => sorted_newsfeed_id_string).first
      
    unless newsfeed_aggregate.present?
      newsfeed_aggregate = NewsfeedAggregate.create(:newsfeed_ids_string => sorted_newsfeed_id_string)
    end

    render :text => newsfeed_aggregate.to_json
  end
  
  #Sort ascending the numbers in newsfeed_ids string
  def sort_numeric_csv_string(str) 
    
    sorted_newsfeed_id_array = []
    
    newsfeed_id_array = str.split(",").each do |v|
      sorted_newsfeed_id_array << v.to_i
    end
    
    sorted_newsfeed_id_string = sorted_newsfeed_id_array.sort!.join(",")  
    
  end
end