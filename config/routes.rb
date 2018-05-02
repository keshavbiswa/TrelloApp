Rails.application.routes.draw do
  resources :boards do
    resources :lists do
      resources :cards
    end
  end
  
  devise_for :users
  root 'home#index'
  get 'contact', to: 'home#contact'
  get 'about', to: 'home#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
