Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # devise_for :admins
  resources :categories
  devise_for :admins
  root 'products#index'
  resources :products do 
  end
  resources :test_articles, path: '/test_articles', only: :index
end
