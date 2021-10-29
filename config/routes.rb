Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"
  resources :links, only: %i[create]
  resources :short_links, path: "s", only: %i[show]
end
