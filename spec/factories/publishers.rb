FactoryGirl.define do
  factory :publisher do
    sequence(:name) { |n| "Publisher ##{n}" }
    
    factory :publisher_nyt do
      name "New York Times"
    end
    
    factory :publisher_wash do
      name "Washington Post"
    end
    
    factory :publisher_tc do
      name "TechCrunch"
    end
    
  end
end
