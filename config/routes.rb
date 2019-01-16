# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: 'users', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks'
  }
  devise_for :admins, path: 'admins', controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords',
    confirmations: 'admins/confirmations',
    unlocks: 'admins/unlocks'
  }
  root 'home#landing_page'
  get '/home', to: 'home#landing_page'

  namespace 'administration' do
    get 'administration/items', to: 'items#index'
    post 'administration/items', to: 'items#update'
    resources :items
  end
end
