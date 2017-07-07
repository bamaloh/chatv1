Rails.application.routes.draw do
  get 'chat/index'

  root to: 'visitors#index'
end
