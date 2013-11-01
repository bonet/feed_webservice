FeedWebservice::Application.routes.draw do
  
  match '/personalized_categories_per_publisher/:newsfeed_aggregate_id', :to => 'categories_per_publishers#show_personalized'
  match '/default_newsfeed_aggregate', :to => 'newsfeed_aggregates#show_default'

  namespace :admin do
    resources :publishers, only: [:new, :create]
    resources :categories, only: [:new, :create]
    resources :newsfeeds, only: [:new, :create]
  end
  
  resources :admin, only: [:index]

  resources :publishers, only:[:show]
  resources :categories, only:[:show]
  resources :newsfeeds, only:[:show]
  resources :newsfeed_aggregates, only:[:create, :show]
  resource :categories_per_publisher, only:[:show]
  
end
