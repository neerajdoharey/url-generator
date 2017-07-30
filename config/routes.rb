Rails.application.routes.draw do

  root :to => 'urls#new'
  get 'generated_url', to: "urls#generated_url"
  get "/:awesome_url", to: "urls#show"

  resources :urls , only:[:create]

  # root to: 'urls#index'
  # get "/:short_url", to: "urls#show"
  # get "shortened/:short_url", to: "urls#shortened", as: :shortened
  # resources :urls, only: :create
end
