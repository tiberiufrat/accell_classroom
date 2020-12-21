require 'sidekiq/web'

Rails.application.routes.draw do
  # get '/oauth', to: 'oauth#authorize'
  # get '/oauth2callback', to: 'oauth#callback'
  get '/redirect', to: 'oauth#redirect', as: 'redirect'
  get '/callback', to: 'oauth#callback', as: 'callback'
  get '/courses_oauth', to: 'oauth#courses_oauth', as: 'courses_oauth'
  resources :courses
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  mount Sidekiq::Web => '/sidekiq'
end
