Rails.application.routes.draw do
  resources :meals, except: [:new, :edit]

  post 'auth/login', to: 'authentication#authenticate'
end
