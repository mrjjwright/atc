ActionController::Routing::Routes.draw do |map|


  map.resources :workouts

  map.resources :abouts

  map.resources :media_profiles

  map.resources :time_slots
  

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  map.connect 'training', :controller => 'home', :action => 'training'
  map.connect 'about', :controller => 'home', :action => 'about'
  map.connect 'about/admin', :controller => 'abouts', :action => 'edit'
  map.connect 'news', :controller => 'media_profiles', :action => 'index'
  map.connect 'news/admin', :controller => 'media_profiles', :action => 'new'
  map.connect 'news/:id', :controller => 'media_profiles', :action => 'show'
  map.connect 'media_profiles/:id/admin', :controller => 'media_profiles', :action => 'edit'
  map.root :controller => 'home'
  map.home ':page', :controller => 'home', :action => 'show', :page => /news|schedule|training|/
  map.admin_landing 'admin', :controller => 'media_profiles', :action => 'edit_last'
  map.admin_athletes 'athletes/admin', :controller => 'athletes', :action => 'index_admin'
  map.admin_athlete 'athletes/:id/admin', :controller => 'athletes', :action => 'edit'
  map.resources :athletes
  
  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
