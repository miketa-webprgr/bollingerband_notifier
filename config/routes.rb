Rails.application.routes.draw do
  root 'companies#index'
  resources :companies do
    resource :search, only: :update
  end
end
