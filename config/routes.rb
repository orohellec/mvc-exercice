# frozen_string_literal: true

Rails.application.routes.draw do
  root 'administration/items#index'
  get '/home', to: 'home#landing_page'

  namespace 'administration' do
    get 'administration/items', to: 'items#index'
    post 'administration/items', to: 'items#update'
    resources :items
  end
end
