Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "books#index"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    get "/logout", to: "sessions#destroy"

    resources :books
  end
end
