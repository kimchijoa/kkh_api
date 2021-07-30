Rails.application.routes.draw do
  get 'apis/test'
  devise_for :users
  post 'auth_user' => 'authentication#authenticate_user'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "books#index"
  get "/book/get_book_data", to: "books#get_book_data"
  get "/book/create_ratio_video", to: "books#create_ratio_video"

  mount V1::Books => '/'
  mount V1::Logins => '/'
end
