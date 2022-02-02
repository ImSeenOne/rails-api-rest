Rails.application.routes.draw do
  resource :users, only: [:create] do
    post "/login", to: "users#login"
    get "/auto_login", to: "users#auto_login"
    post"/register", to: "users#create"

    get '/posts/:id', to: 'post#show'
    get '/posts/list', to: 'post#list'
    post '/posts/new', to: 'post#create'
    delete '/posts/', to: 'post#delete'
  end
 end
