FactoryGirl.define do
  factory :newsfeed do
    
    factory :nyt_tech_newsfeed do
      category_id { get_category_id(:category_tech) }
      publisher_id { get_publisher_id(:publisher_nyt) }
      feed_urls "http://rss.nytimes.com/services/xml/rss/nyt/Technology.xml, http://rss.nytimes.com/services/xml/rss/nyt/Science.xml, http://rss.nytimes.com/services/xml/rss/nyt/Automobiles.xml"
    end
    
    factory :nyt_arts_newsfeed do
      category_id { get_category_id(:category_art) }
      publisher_id { get_publisher_id(:publisher_nyt) } 
      feed_urls "http://rss.nytimes.com/services/xml/rss/nyt/Arts.xml, http://rss.nytimes.com/services/xml/rss/nyt/Books.xml, http://rss.nytimes.com/services/xml/rss/nyt/Movies.xml"
    end
    
    factory :wash_business_newsfeed do
      category_id { get_category_id(:category_business) }
      publisher_id { get_publisher_id(:publisher_wash) }
      feed_urls "http://feeds.washingtonpost.com/rss/business, http://feeds.washingtonpost.com/rss/business/local-business, http://feeds.washingtonpost.com/rss/capital_business"
    end
    
    factory :wash_arts_newsfeed do
      category_id { get_category_id(:category_art) }
      publisher_id { get_publisher_id(:publisher_wash) }
      feed_urls "http://feeds.washingtonpost.com/rss/entertainment/museums, http://feeds.washingtonpost.com/rss/entertainment/music, http://feeds.washingtonpost.com/rss/entertainment/theater-dance"
    end
  end
end