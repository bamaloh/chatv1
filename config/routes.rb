Rails.application.routes.draw do
  get 'chat/' => "chat#index"
  post 'chat/' => "chat#post"
  post 'bot_response/' => "chat#bot_response"
  root to: 'visitors#index'
  get 'reset/' => "application#reset"
end
