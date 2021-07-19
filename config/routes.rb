Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "books#index"
  get "/book/get_book_data", to: "books#get_book_data"
  mount V1::Books => '/'
end
