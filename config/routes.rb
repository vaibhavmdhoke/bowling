Rails.application.routes.draw do
  resources :players
  resources :games
  resources :rolls
  resources :frames
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
