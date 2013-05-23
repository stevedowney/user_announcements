Rails.application.routes.draw do
  
  resources :hidden_announcements, path: '/announcements', only: [:index, :create, :destroy]

  namespace :admin do
    resources :announcements
  end

end
