Rails.application.routes.draw do
  resources :courses do
    resources :examinations do
      resources :scores, only: [:index]
      patch 'scores/edit', to: 'scores#update' 
    end
    resources :students, except: [:show]
  end

  devise_for :users, skip: :all

  # if user authenticated then root is courses page
  authenticated :user do
    root 'courses#index', as: :authenticated_root
  end

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    post 'sign_in', to: 'devise/sessions#create', as: :user_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session

    root to: redirect('/sign_in')

    patch 'set_locale', to: 'locale#set_locale'
    match "/404", :to => "errors#not_found", :via => :all, :as => :not_found
    match "/500", :to => "errors#internal_server_error", :via => :all
  end
end
