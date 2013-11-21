GAN::Application.routes.draw do
  
  get "registrations/new"

  devise_scope :user do
    get '/friend/register' => 'users/registrations#new', :type => 'Friend', as: :new_friend_registration
    get '/alum/register' => 'users/registrations#new', :type => 'Alum', as: :new_alum_registration
    
    get '/' => 'devise/sessions#new', as: :root
  end

  # get '/users/aregister' => 'users/registrations#new', :type => 'Alum', as: :new_alum_registration
  # get '/users/fregister' => 'users/registrations#new', :type => 'Friend', as: :new_friend_registration

  devise_for :users, :controllers => {:registrations => 'users/registrations'}
  
  resources :opportunities do
    resources :applications
  end
  

  get '/about' => 'opportunities#about', as: :about
  get '/account' => 'users#account', as: :my_account
  get '/users/signup' => 'users#sign_up', as: :new_user_signup
  get "/main" => 'opportunities#main', as: :main

  post '/import' => "userdbs#import", as: :import_users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


  # You can have the root of your site routed with "root"
  # root 'devise/sessions#new'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
