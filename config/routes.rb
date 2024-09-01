Rails.application.routes.draw do
  # get 'home/index'


  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }


  devise_scope :user do

  # root 'devise/sessions#new' 
  # root 'home#index' 

  post 'verify_otp', to: 'users/registrations#verify_otp',as: 'verify_otp'

  get 'otp_verification', to: 'users/registrations#otp_verification',as: :otp_verification

  post 'resend_otp', to: 'users/registrations#resend_otp',as: 'resend_otp'

  get '/users/sign_out' => 'devise/sessions#destroy'


  get 'audit_log', to: 'projects#audit_log' # Adjust the controller and action name as necessary

  post 'revert_version/:id/:version_id', to: 'projects#revert_version', as: 'revert_version'

  end


  root 'projects#index'
 
resources :projects do
  
  resources :tasks do
    member do
      patch :update_status
    end
  end
  
  collection do
    get 'audit_log'
  end

  member do
    patch 'revert'
  end

  member do
    get 'revert'
  end
end


resources :tasks

resources :meetings, only: [:index, :create]




  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
