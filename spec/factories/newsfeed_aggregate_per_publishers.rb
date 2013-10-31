FactoryGirl.define do
  factory :newsfeed_aggregate_per_publisher do
    
    factory :newsfeed_aggregate_per_publisher_nyt do
      newsfeed_ids_string { [FactoryGirl.create(:nyt_tech_newsfeed)._id, FactoryGirl.create(:nyt_arts_newsfeed)._id].join(",") }
      publisher_id { get_publisher(:publisher_nyt)._id }
      publisher_name { get_publisher(:publisher_nyt).name }
    end
    
    factory :newsfeed_aggregate_per_publisher_wash do
      newsfeed_ids_string { [FactoryGirl.create(:wash_business_newsfeed)._id, FactoryGirl.create(:wash_arts_newsfeed)._id].join(",") }
      publisher_id { get_publisher(:publisher_wash)._id }
      publisher_name { get_publisher(:publisher_wash).name }
    end
    
  end
end