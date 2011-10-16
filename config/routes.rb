Balance::Application.routes.draw do  
  match '/auth/failure' => 'contour/authentications#failure'
  match '/auth/:provider/callback' => 'contour/authentications#create'
  match '/auth/:provider' => 'contour/authentications#passthru'

  resources :authentications, :controller => 'contour/authentications'

  resources :accounts do
    get :search, :on => :collection
  end

  resources :charge_types do
    get :search, :on => :collection
  end
  
  resources :entries do
    post :mark_charged, :on => :member
    collection do
      get :overview
      get :earning_spending_graph
      get :autocomplete
      get :averages
      get :current_balance
    end
  end
  
  devise_for :users, :controllers => {:registrations => 'contour/registrations', :sessions => 'contour/sessions', :passwords => 'contour/passwords'}, :path_names => { :sign_up => 'register', :sign_in => 'login' }
  
  match "/about" => "sites#about", :as => :about
  match "/dashboard" => "users#dashboard", :as => :dashboard
  
  root :to => "users#dashboard"
end
