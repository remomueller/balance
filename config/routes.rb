Balance::Application.routes.draw do  
  devise_for :users

  resources :accounts do
    post :search, :on => :collection
  end
  
  resources :announcements do
    post :hide, :on => :collection
  end

  resources :charge_types do
    post :search, :on => :collection
  end
  
  resources :entries do
    post :mark_charged, :on => :member
    collection do
      post :search
      get :overview
      post :earning_spending_graph
      post :auto_complete_for_entry_name
    end
  end
  
  root :to => "users#dashboard"

  match "/dashboard" => "users#dashboard", :as => :dashboard
end
