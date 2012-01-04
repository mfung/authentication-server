Authentication::Application.routes.draw do

  namespace :admin do resources :departments end

  devise_for :users, :controllers => {  :registrations => 'registrations',
                                        :sessions => 'sessions'}
                                        
  # Provider
  match '/authorize/exteres/authorize' => 'authorize#authorize'
  match '/authorize/exteres/access_token' => 'authorize#access_token'
  match '/authorize/exteres/user' => 'authorize#user'
  match '/oauth/token' => 'authorize#access_token'
  
  match 'login' => redirect('/users/sign_in'), :as => :login
      
  root :to => 'home#index'
  
  namespace :admin do    
    resources :users do 
      resources :user_apps, :as => 'applications' do 
        post :role
        post :default_user
      end
    end
    
    resources :apps

    match '/users/add_apps' => 'users#add_apps', :via => :post
    match '/users/remove_app/:id/with_user/:user_id' => 'users#remove_app', :via => :get, :as => 'users_remove_app'
    match '/users/remove_apps' => 'users#remove_apps', :via => :post
    match '/apps/sync_roles' => 'apps#sync_roles'
    match '/users/change_role' => 'users#change_role', :via => :post
    match '/users/change_status' => 'users#change_status', :via => :post
  end
  
  resources :apps
  
  resources :my_account
  
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
  # match ':controller(/:action(/:id(.:format)))'
end
