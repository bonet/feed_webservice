class NewsfeedAggregatesController < ApplicationController
  
  
  # Sample output: 
  # 
  # {
  #   "_id":1,
  #   "newsfeed_aggregate_per_category_ids":[1,2],
  #   "newsfeed_aggregate_per_categories":
  #   [
  #     {
  #       "_id":1,
  #       "category_id":1,
  #       "category_name":"Technology",
  #       "newsfeed_aggregate_ids":[1],
  #       "newsfeed_ids_string":"1,2,4"
  #       "content_urls": {
  #                          "2013-11-11T04:13:08+00:00": [
  #                                                         {"title":"DealBook: BlackBerry\u2019s Woes Draw Canada\u2019s Contrarian Mogul Into Spotlight","link":"http://dealbook.nytimes.com/2013/11/10/blackberrys-woes-draw-canadas-contrarian-mogul-into-spotlight/?partner=rss&amp;emc=rss"}
  #                                                       ],
  #                          "2013-11-11T03:29:31+00:00": [
  #                                                         {"title":"Start-Ups Are Mining Hyperlocal Information for Global Insights","link":"http://www.nytimes.com/2013/11/11/technology/gathering-more-data-faster-to-produce-more-up-to-date-information.html?partner=rss&amp;emc=rss"}
  #                                                       ]
  #                       },
  # 
  #     },
  # 
  #     {
  #       "_id":2,
  #       "category_id":2,
  #       "category_name":"Art",
  #       "newsfeed_aggregate_ids":[1],
  #       "newsfeed_ids_string":"1,2,4"
  #       "content_urls": {
  #                          "2013-11-11T05:11:00+00:00": [
  #                                                          {"title":"Media Decoder: Gun Violence in American Movies Is Rising, Study Finds","link":"http://www.nytimes.com/2013/11/11/business/media/gun-violence-in-american-movies-is-rising-study-finds.html?partner=rss&amp;emc=rss"}
  #                                                        ]
  #                       },
  # 
  #    }
  #   ],
  #   
  #   "newsfeed_aggregate_per_publisher_ids":[1,2],
  #   "newsfeed_aggregate_per_publishers":
  #   [
  #     {
  #       "_id":1,
  #       "publisher_id":1,
  #       "publisher_name":"New York Times",
  #       "newsfeed_aggregate_ids":[1],
  #       "newsfeed_ids_string":"1,2,4",
  #       "content_urls": {
  #                          "2013-11-11T04:13:08+00:00": [
  #                                                          {"title":"DealBook: BlackBerry\u2019s Woes Draw Canada\u2019s Contrarian Mogul Into Spotlight","link":"http://dealbook.nytimes.com/2013/11/10/blackberrys-woes-draw-canadas-contrarian-mogul-into-spotlight/?partner=rss&amp;emc=rss"}
  #                                                       ],
  #                          "2013-11-11T03:29:31+00:00": [
  #                                                          {"title":"Start-Ups Are Mining Hyperlocal Information for Global Insights","link":"http://www.nytimes.com/2013/11/11/technology/gathering-more-data-faster-to-produce-more-up-to-date-information.html?partner=rss&amp;emc=rss"}
  #                                                       ]
  #                       },
  #     },
  #   
  #     {
  #       "_id":2,
  #       "newsfeed_aggregate_ids":[1],
  #       "newsfeed_ids_string":"1,2,4",
  #       "publisher_id":2,
  #       "publisher_name":"Washington Post",
  #       "content_urls": {
  #                                 "2013-11-08T22:20:11+00:00": [
  #                                                                 {"title":"More \u2018Pieces of Amber,\u2019 in which we hear from Amber herself","link":"http://feeds.washingtonpost.com/c/34656/f/636575/s/3378c0db/sc/38/l/0L0Swashingtonpost0N0Cblogs0Cgoing0Eout0Egurus0Cpost0Cmore0Epieces0Eof0Eamber0Ein0Ewhich0Ewe0Ehear0Efrom0Eamber0Eherself0C20A130C110C0A80Cebf80A8720E48c30E11e30E95a90E3f15b5618ba80Iblog0Bhtml0Dwprss0Frss0Imuseums/story01.htm"}
  #                                                              ]
  #                       }
  #     }
  #   ],
  # 
  #   "updated":"2013-11-11T14:00:51+07:00"
  # }
  
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