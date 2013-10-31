FactoryGirl.define do
  factory :category do
    
    sequence(:name) { |n| "Category ##{n}" }
    
    factory :category_art do
      name "Art"
    end
    
    factory :category_science do
      name "Science"
    end
    
    factory :category_tech do
      name "Technology"
    end
    
    factory :category_business do
      name "Business"
    end
  end
end
