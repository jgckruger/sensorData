Rails.application.routes.draw do
  get 'measurements/showMeasurements'

  get 'measurements_controller/showMeasurements'

  devise_for :users
  get 'homepage/index'
  root 'homepage#index'
  resources :measurements
  resources :devices
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
