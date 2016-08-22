Rails.application.routes.draw do

  root to: "sites#index"

  devise_for :users

  get "/user", to: "users#show", as: "user_root"

  authenticated :user do
    root to: "users#show", as: "authenticated_root"
  end

end
