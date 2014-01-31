GAN::Application.routes.draw do
  
  devise_for :admins

  get "admins/applications" => "admins#view_all_applications", as: :admin_applications
  get 'admins/applications/export' => "admins#export_applications", as: :export_applications
  get 'admins/users/new' => "admins/users#new", as: :admins_new_user
  post 'admins/users' => "admins/users#create"

  get "admins/invitations" => "admins#invitations", as: :invitations
  get "admins/alum" => "admins#view_alum_list", as: :alum_list

  namespace :admins do
    resources :users
    resources :posts
  end

  get "/contacts/new" => "contacts#new", as: :new_contact
  post "/contacts" => "contacts#create"

  resources :opportunities do
    resources :applications
  end
  
  get '/welcome' => "opportunities#welcome", as: :welcome
  get '/opportunities/new/upload' => "opportunities#upload", as: :new_upload

  devise_scope :user do
    get '/friend/register' => 'users/registrations#new', :type => 'Friend', as: :new_friend_registration
    get '/alum/register' => 'users/registrations#new', :type => 'Alum', as: :new_alum_registration
    
    get '/invitations/batch' => "users/invitations#batch_new", as: :new_batch_invite

    post '/invitation' => "users/invitations#batch_invite", as: :batch_invite


    get '/' => 'users/sessions#new', as: :root
  end

  as :user do
    patch '/users/confirmation' => 'confirmations#update', :via => :patch, :as => :update_user_confirmation
  end
  
  devise_for :users, :controllers => {:registrations => 'users/registrations', :confirmations => "confirmations", :invitations => "users/invitations", :sessions => "users/sessions"}
  
  get '/contact' => 'opportunities#contact', as: :contact
  get '/about' => 'opportunities#about', as: :about
  
  get '/account' => 'users#account', as: :account
  get '/my_opportunities' => 'opportunities#my_index', as: :my_opportunities
#  get '/users/signup' => 'users#sign_up', as: :new_user_signup

  #The main page after sign in
  get "/main" => 'opportunities#main', as: :main

  #Path for importing CSV files
  post '/import' => "userdbs#import", as: :import_users



  get '/opportunities/add_to_favorites/:id' => "opportunities#add_to_favorites", as: :new_favorite_opportunity
  post '/opportunities/remove_from_favorites/:id' => "opportunities#remove_from_favorites"

  get '/opportunities/:id/download/:upload_id', :controller => 'opportunities', :action =>'download', as: :download
  get '/opportunities/:id/view/:upload_id' => "opportunities#view", as: :view
  get '/users/:user_id/download/:id' => 'users#download', as: :user_attachment_download
  get 'users/:id' => 'users#show', as: :user



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
