Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :people
  resources :charts, only: ['index']
  root :to => 'welcome#index'
end
