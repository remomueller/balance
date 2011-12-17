Balance::Application.routes.draw do  

  resources :accounts do
    get :search, :on => :collection
  end

  resources :charge_types do
    get :search, :on => :collection
  end
  
  resources :entries do
    post :mark_charged, :on => :member
    collection do
      get :calendar
      get :overview
      get :earning_spending_graph
      get :autocomplete
      get :averages
      get :current_balance
    end
  end
  
  devise_for :users, controllers: { registrations: 'contour/registrations',
                                         sessions: 'contour/sessions',
                                        passwords: 'contour/passwords' },
                     path_names:  {       sign_up: 'register',
                                          sign_in: 'login' }
  
  match "/about" => "sites#about", :as => :about
  
  root :to => "entries#calendar"
  
end
