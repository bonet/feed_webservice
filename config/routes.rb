FeedWebservice::Application.routes.draw do
  
  match '/admin/', :to => 'admin#index'
  match '/admin/publisher', :to => 'publishers#new'
  match '/admin/category', :to => 'categories#new'
  match '/admin/pub_cat', :to => 'pub_cats#new'
  
  match '/get_pub_cat_namelist', :to => 'pub_cats#get_pub_cat_namelist'
  match '/get_personalized_pub_cat_aggregate/:id', :to => 'pub_cat_aggregates#show'
  match '/get_default_pub_cat_aggregate', :to => 'pub_cat_aggregates#show_default'
  match '/register_pub_cats', :to => 'pub_cat_aggregates#new'
  
  match '/cron/update_pub_cat_namelist', :to => 'pub_cats#update_pub_cat_namelist'
  match '/cron/pub_cat_aggregates/update', :to => 'pub_cat_aggregates#cron_update'

  
  resources :publishers
  resources :categories
  resources :pub_cats
  resources :pub_cat_aggregates
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
