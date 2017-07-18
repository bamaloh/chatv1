Rails.application.routes.draw do
  get 'chat/' => "chat#index"
  post 'chat/' => "chat#post"
  root to: 'visitors#index'
end
