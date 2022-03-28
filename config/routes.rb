Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "books#index"

    resources :books
  end
end
