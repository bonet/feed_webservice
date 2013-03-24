FeedWebservice::Application.routes.draw do
  
  match '/admin/', :to => 'admin#index'
  match '/admin/publisher', :to => 'publishers#new'
  match '/admin/category', :to => 'categories#new'
  match '/admin/pub_cat', :to => 'pub_cats#new'
  
  match '/get_pub_cat_namelist', :to => 'pub_cats#get_pub_cat_namelist'
  match '/get_personalized_pub_cat_aggregate/:id', :to => 'pub_cat_aggregates#show'
  match '/get_default_pub_cat_aggregate', :to => 'pub_cat_aggregates#show_default'
  match '/register_pub_cats', :to => 'pub_cat_aggregates#new'
  
  match '/cron/update_pub_cat_namelist', :to => 'pub_cats#cron_update_pub_cat_namelist'
  match '/cron/update_pub_cat_aggregates', :to => 'pub_cat_aggregates#cron_update_pub_cat_aggregates'

  
  resources :publishers
  resources :categories
  resources :pub_cats
  resources :pub_cat_aggregates
  
end
