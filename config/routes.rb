Rails.application.routes.draw do
  get 'home/index'


  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do

  # root 'devise/sessions#new' 
  # root 'home#index' 

  post 'verify_otp', to: 'users/registrations#verify_otp',as: 'verify_otp'

  get 'otp_verification', to: 'users/registrations#otp_verification',as: :otp_verification

  post 'resend_otp', to: 'users/registrations#resend_otp',as: 'resend_otp'

  end


  root 'projects#index'
 
  resources :projects do
      resources :tasks
  end  





  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
