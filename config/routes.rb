Rails.application.routes.draw do
  get "/sign_in", to: "auth#new"
  get "/sign_out", to: "auth#destroy"
  get "/auth/:provider/callback", to: "auth#callback"
  get "/auth/weibo", to: "auth#weibo"

  root 'index#index'
  get '/play', to: 'index#play'
  get '/s/:id', to: 'stories#show' 
end
