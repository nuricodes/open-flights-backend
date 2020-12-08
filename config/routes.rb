Rails.application.routes.draw do
  root 'pages#index'

  #namespacing your api keeps the api independent by giving it it's own controllers and routes
  namespace :api do
    namespace :v1 do
      resources :airlines, param: :slug #the param we set for this is slug instead of an id as the primary param
      resources :reviews, only: [:create, :destroy]

    end
  end

  #routes req that arent for existing paths that aren't in our api back to our index path
  #lets us handle the routing to our react components without interferring with our actual rails routes for our api
  get '*path', to: 'pages#index', via: :all
end
