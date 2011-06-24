Balance::Application.routes.draw do  
  devise_for :users, :path_names => { :sign_up => 'register', :sign_in => 'login' }

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
    end
  end
  
  match "/about" => "sites#about", :as => :about
  match "/dashboard" => "users#dashboard", :as => :dashboard
  
  root :to => "users#dashboard"
end
