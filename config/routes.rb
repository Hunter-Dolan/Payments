Payments::Application.routes.draw do
  
  root to: "welcome#index"
  
  devise_for :users
  resources :invoices do 
    get :pay
  end

end
