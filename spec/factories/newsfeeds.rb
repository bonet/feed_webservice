FactoryGirl.define do
  factory :newsfeed do
    
    factory :nyt_tech_newsfeed do
      category_id { get_category(:category_tech)._id }
      publisher_id { get_publisher(:publisher_nyt)._id }
      feed_urls "http://rss.nytimes.com/services/xml/rss/nyt/Technology.xml, http://rss.nytimes.com/services/xml/rss/nyt/Science.xml, http://rss.nytimes.com/services/xml/rss/nyt/Automobiles.xml"
    end
    
    factory :nyt_arts_newsfeed do
      category_id { get_category(:category_art)._id }
      publisher_id { get_publisher(:publisher_nyt)._id } 
      feed_urls "http://rss.nytimes.com/services/xml/rss/nyt/Arts.xml, http://rss.nytimes.com/services/xml/rss/nyt/Books.xml, http://rss.nytimes.com/services/xml/rss/nyt/Movies.xml"
    end
    
    factory :wash_business_newsfeed do
      category_id { get_category(:category_business)._id }
      publisher_id { get_publisher(:publisher_wash)._id }
      feed_urls "http://feeds.washingtonpost.com/rss/business, http://feeds.washingtonpost.com/rss/business/local-business, http://feeds.washingtonpost.com/rss/capital_business"
    end
    
    factory :wash_arts_newsfeed do
      category_id { get_category(:category_art)._id }
      publisher_id { get_publisher(:publisher_wash)._id }
      feed_urls "http://feeds.washingtonpost.com/rss/entertainment/museums, http://feeds.washingtonpost.com/rss/entertainment/music, http://feeds.washingtonpost.com/rss/entertainment/theater-dance"
    end
  end
end