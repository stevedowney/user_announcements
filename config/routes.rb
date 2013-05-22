Rails.application.routes.draw do
  
  resources :user_announcements, path: '/announcements' do
    get :hide, on: :member
    post :unhide, on: :member
  end
# match 'announcements/:id/hide', to: 'announcements#hide', as: 'hide_announcement'
  namespace :admin do
    resources :announcements
  end

end
