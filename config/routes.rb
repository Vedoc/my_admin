Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  post '/api/promotions', to: 'api/promotions#create'

  namespace :v1 do
    resources :vehicles, only: %i[create index update destroy]
    resources :service_requests, only: %i[create index destroy show]

    get 'car_makes', to: 'service_requests#car_makes'
    get 'car_models', to: 'service_requests#car_models'
    get 'model_years', to: 'service_requests#model_years'
    get 'settings', to: 'service_requests#settings_index'

    post 'auth', to: 'auth#create'
  end
end
