FactoryGirl.define do
  factory :newsfeed do
    category_id { FactoryGirl.create(:category)._id }
    publisher_id { FactoryGirl.create(:publisher)._id }
    
    trait :nyt_tech_rss do
      feed_urls "http://rss.nytimes.com/services/xml/rss/nyt/Technology.xml, http://rss.nytimes.com/services/xml/rss/nyt/Science.xml, http://rss.nytimes.com/services/xml/rss/nyt/Automobiles.xml"
    end
    
    trait :nyt_arts_rss do
      feed_urls "http://rss.nytimes.com/services/xml/rss/nyt/Arts.xml, http://rss.nytimes.com/services/xml/rss/nyt/Books.xml, http://rss.nytimes.com/services/xml/rss/nyt/Movies.xml"
    end
    
    factory :nyt_tech_rss_newsfeed, traits: [:nyt_tech_rss]
    factory :nyt_arts_rss_newsfeed, traits: [:nyt_arts_rss]
  end
end