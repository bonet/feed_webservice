class CategoriesPerPublishersController < ApplicationController
  
  # Action        : show
  # Output sample :
  #
  # {
  #  "1":
  #   {
  #     "publisher_id":1,
  #     "publisher_name":"New York Times",
  #     "categories": [
  #                     {"newsfeed_id":1,"category_id":1,"category_name":"Technology"},
  #                     {"newsfeed_id":2,"category_id":2,"category_name":"Art"}
  #                   ]
  #   },
  #  "2":
  #   {
  #     "publisher_id":2,
  #     "publisher_name":"Washington Post",
  #     "categories": [
  #                     {"newsfeed_id":3,"category_id":3,"category_name":"Business"},
  #                     {"newsfeed_id":4,"category_id":2,"category_name":"Art"}
  #                   ]
  #   }
  # }
  
  def show
    if CategoriesPerPublisher.count > 0
      render :text => CategoriesPerPublisher.first.namelist.to_json
    else 
      render :nothing => true
    end
  end
  
  
  
  # Action        : show_personalized 
  # Output sample :
  # 
  # {"1":
  #       {
  #         "publisher_id":1,
  #         "publisher_name":"New York Times",
  #         "categories":
  #                       [
  #                         {"newsfeed_id":1,"category_id":1,"category_name":"Technology","owned":"false"},
  #                         {"newsfeed_id":2,"category_id":2,"category_name":"Art","owned":"true"}
  #                       ]
  #       },
  #  "2":
  #       {
  #         "publisher_id":2,
  #         "publisher_name":"Washington Post",
  #         "categories":
  #                       [
  #                         {"newsfeed_id":3,"category_id":3,"category_name":"Business","owned":"true"},
  #                         {"newsfeed_id":4,"category_id":2,"category_name":"Art","owned":"true"}
  #                       ]
  #       }
  # }

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