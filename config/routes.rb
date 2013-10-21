FeedWebservice::Application.routes.draw do
  
  match '/get_personalized_pub_cat_namelist/:pub_cat_aggregate_id', :to => 'pub_cats#get_personalized_pub_cat_namelist'
  match '/get_pub_cat_namelist', :to => 'pub_cats#get_pub_cat_namelist'
  match '/get_personalized_pub_cat_aggregate/:id', :to => 'pub_cat_aggregates#show'
  match '/get_default_pub_cat_aggregate', :to => 'pub_cat_aggregates#show_default'
  match '/register_pub_cats', :to => 'pub_cat_aggregates#new'
  
  match '/cron/update_pub_cat_namelist', :to => 'pub_cats#cron_update_pub_cat_namelist'
  match '/cron/update_pub_cat_aggregates', :to => 'pub_cat_aggregates#cron_update_pub_cat_aggregates'

  namespace :admin do
    resources :publishers, only: [:new, :create]
    resources :categories, only: [:new, :create]
    resources :newsfeeds, only: [:new, :create]
  end
  
  resources :admin, only: [:index]

  resources :publishers, only:[:show]
  resources :categories, only:[:show]
  resources :newsfeeds, only:[:show]
  #resources :pub_cat_aggregates
  
end
