FactoryGirl.define do
  factory :publisher do
    sequence(:name) { |n| "Publisher ##{n}" }
  end
end
