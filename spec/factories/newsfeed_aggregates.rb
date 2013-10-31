FactoryGirl.define do
  factory :newsfeed_aggregate do
    newsfeed_ids_string { ( FactoryGirl.create(:newsfeed_aggregate_per_publisher_nyt).newsfeed_ids_string.split(",") | 
                               FactoryGirl.create(:newsfeed_aggregate_per_publisher_wash).newsfeed_ids_string.split(",") |
                               FactoryGirl.create(:newsfeed_aggregate_per_category_art).newsfeed_ids_string.split(",") 
                             ).uniq.join(",") }
    
  end
end