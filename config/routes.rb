Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "books#index"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    get "/logout", to: "sessions#destroy"

    resources :books

    namespace :admin do
      resources :borrowed_requests, only: :index do
        collection do
          put :handle_status
        end
      end
    end
  end
end
