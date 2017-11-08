Rails.application.routes.draw do
  post "/users", to: "users#create"
  post "/messages", to: "messages#create"
  get "/messages/:current_user_id/:target_user_id", to: "messages#show"
end
