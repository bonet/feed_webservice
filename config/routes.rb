FeedWebservice::Application.routes.draw do

  match '/categories_per_publishers/:newsfeed_aggregate_id', :to => 'categories_per_publishers#show'
  match '/default_categories_per_publisher', :to => 'categories_per_publishers#show_default'
  
  match '/default_newsfeed_aggregate', :to => 'newsfeed_aggregates#show_default'
   
  namespace :admin do
    resources :publishers, only: [:new, :create]
    resources :categories, only: [:new, :create]
    resources :newsfeeds, only: [:new, :create]
  end
  
  resources :admin, only: [:index]

  resources :newsfeed_aggregates, only: [:create, :show]
  
end
