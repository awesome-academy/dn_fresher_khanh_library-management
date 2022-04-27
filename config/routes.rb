Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "books#index"

    devise_for :users

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
