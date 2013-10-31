FactoryGirl.define do
  factory :newsfeed_aggregate_per_category do
    
    factory :newsfeed_aggregate_per_category_art do
      newsfeed_ids_string { [FactoryGirl.create(:wash_arts_newsfeed)._id, FactoryGirl.create(:nyt_arts_newsfeed)._id].join(",") }
      category_id { get_category(:category_art)._id }
      category_name { get_category(:category_art).name }
    end
    
    factory :newsfeed_aggregate_per_category_business do
      newsfeed_ids_string { [FactoryGirl.create(:wash_business_newsfeed)._id].join(",") }
      category_id { get_category(:category_business)._id }
      category_name { get_category(:category_business).name }
    end
    
  end
end