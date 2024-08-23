Rails.application.routes.draw do


  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  post 'verify_otp', to: 'users/registrations#verify_otp',as: 'verify_otp'
  post 'resend_otp', to: 'users/registrations#resend_otp',as: 'resend_otp'

  root 'home#index' # Adjust to your actual root path

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
