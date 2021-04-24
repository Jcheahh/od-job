Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :jobs do
    collection do
      get "mine"
    end
  end
  resources :claims

  root "application#home"
end
