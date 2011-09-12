DietApp::Application.routes.draw do
  resources :meals

  resources :announcements

  resources :users
  resources :sessions, :only => [:new, :create, :destroy]  
  resources :foods
  
  get "sessions/new"

  get "users/new"
  
  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#create'
  match '/signout', :to => 'sessions#destroy'

  match '/login',   :to => 'pages#login' 
  
  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
  match '/help/tutorial', :to => 'pages#tutorial' 
  match '/help/report-a-problem', :to => 'pages#report-a-problem' 

  
  
  match '/analysis', :to => 'users#analysis'
  match '/terms',    :to => 'pages#terms'
  match '/privacy',  :to => 'pages#privacy_statement'
  match '/faq',      :to => 'pages#faq'
    
  match '/foods',    :to => 'foods#index'
  match '/foods/search', :to => 'foods#show'

  root :to => 'pages#home'

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

ActionController::Routing::Routes.draw do |map|
  map.root :controller => "application_controller"
  map.connect ':controller/:action/:id'
end
