Balance::Application.routes.draw do  
  devise_for :users, :path_names => { :sign_up => 'register', :sign_in => 'login' }

  resources :accounts do
    post :search, :on => :collection
  end

  resources :charge_types do
    post :search, :on => :collection
  end
  
  resources :entries do
    post :mark_charged, :on => :member
    collection do
      get :overview
      post :earning_spending_graph
      post :auto_complete_for_entry_name
    end
  end
  
  match "/about" => "sites#about", :as => :about
  match "/dashboard" => "users#dashboard", :as => :dashboard
  
  root :to => "users#dashboard"
end
