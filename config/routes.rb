Rails.application.routes.draw do
  get 'claim/show'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :job

  root "application#home"
end
