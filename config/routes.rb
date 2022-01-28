Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  #namespace :api, constraints: { format: 'json' } do
  #  namespace :v1 do
  #    get 'posts/:id', to: 'post#show'
  #    post 'posts/new', to: 'post#create'
      #get '/posts/:id', to: 'post#show'
  #  end
  #end
  get '/post/:id', to: 'post#show'
  get 'posts/list', to: 'post#list'
  post 'posts/new', to: 'post#create'
  delete 'post/', to: 'post#delete'
 end
