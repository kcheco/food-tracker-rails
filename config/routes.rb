Rails.application.routes.draw do
  resources :meals, except: [:new, :edit]
end
