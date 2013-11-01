class CategoriesPerPublishersController < ApplicationController
  
  def show
    if CategoriesPerPublisher.count > 0
      render :text => CategoriesPerPublisher.first.namelist.to_json
    else 
      render :nothing => true
    end
  end
  
  def show_personalized
    newsfeed_aggregate = NewsfeedAggregate.find(params[:newsfeed_aggregate_id])
    
    if newsfeed_aggregate.nil?
      render :nothing => true
    else
      newsfeed_ids_array = newsfeed_aggregate['newsfeed_ids_string'].split(",")
      
      result = {}
      CategoriesPerPublisher.first.namelist.each do |k,v|
        
        v['categories'].each_with_index do |n,m|
          
          if newsfeed_ids_array.include? n['newsfeed_id'].to_s
            v['categories'][m.to_i]['owned'] = "true"
          else
            v['categories'][m.to_i]['owned'] = "false"
          end
          
        end
        
        result[k] = v
      end
      
      render :text => result.to_json
    end
  end
end