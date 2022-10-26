Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "incoming_messages#index"

  post '/webhooks/:source', to: 'webhooks#create'
end
