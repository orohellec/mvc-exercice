# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords'
  }
  root 'home#landing_page'
  get '/home', to: 'home#landing_page'

  namespace 'administration' do
    get 'administration/items', to: 'items#index'
    post 'administration/items', to: 'items#update'
    resources :items
  end
end
