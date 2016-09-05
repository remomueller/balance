# frozen_string_literal: true

Rails.application.routes.draw do
  root 'entries#calendar'

  resources :accounts do
    get :search, on: :collection
  end

  resources :charge_types, path: 'charge-types' do
    get :search, on: :collection
  end

  resources :entries do
    member do
      post :mark_charged
      get :copy
      post :move
    end
    collection do
      get :calendar
      get :overview
      get :earning_spending_graph
      get :autocomplete
      get :averages
      get :current_balance, path: 'current-balance'
    end
  end

  resources :templates do
    collection do
      post :add_item
      post :launch_template
    end
  end

  devise_for :users, path_names: { sign_up: 'join', sign_in: 'login' }, path: ''

  get '/about' => 'application#about', as: :about
  get '/month' => 'entries#calendar', as: :calendar

  scope module: :application do
    get :version
  end

  scope module: :internal do
    get :backup
    get :backup_failed, path: 'backup/failed'
    get :backup_succeeded, path: 'backup/succeeded'
    get :generate_backup, to: redirect('backup')
    post :generate_backup
  end
end
