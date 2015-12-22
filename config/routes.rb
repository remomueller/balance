Rails.application.routes.draw do
  resources :accounts do
    get :search, on: :collection
  end

  resources :charge_types do
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
      get :current_balance
    end
  end

  devise_for :users,  controllers: { registrations: 'contour/registrations',
                                          sessions: 'contour/sessions',
                                         passwords: 'contour/passwords' },
                      path_names:  {       sign_up: 'register',
                                           sign_in: 'login' },
                      path: ''

  get '/about' => 'application#about', as: :about
  get '/month' => 'entries#calendar', as: :calendar

  scope module: 'application' do
    get :version
  end

  root to: 'entries#calendar'
end
