Rails.application.routes.draw do

  root to: "courses#index"

  resources :courses
  #User routes
  devise_for :users, skip: :all

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    post 'sign_in', to: 'devise/sessions#create', as: :user_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

end
