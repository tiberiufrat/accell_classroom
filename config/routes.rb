require 'sidekiq/web'

Rails.application.routes.draw do
  resources :activities
  resources :reports
  resources :course_works
  resources :course_work_materials
  resources :announcements
  resources :forms
  resources :links
  resources :youtube_videos
  resources :drive_files
  resources :courses
  # get '/oauth', to: 'oauth#authorize'
  # get '/oauth2callback', to: 'oauth#callback'
  get '/redirect', to: 'oauth#redirect', as: 'redirect'
  get '/callback', to: 'oauth#callback', as: 'callback'
  get '/courses_oauth', to: 'oauth#courses_oauth', as: 'courses_oauth'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  mount Sidekiq::Web => '/sidekiq'
end
