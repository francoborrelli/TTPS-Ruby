Rails.application.routes.draw do

  resources :courses do 
    resources :students, except: [:show]
    resources :examinations, except: [:show]
  end


  #User routes
  devise_for :users, skip: :all

  #if user authenticated then root is courses page
  authenticated :user do
    root 'courses#index', as: :authenticated_root
  end

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    post 'sign_in', to: 'devise/sessions#create', as: :user_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session

    #if user is not authenticated redirect to singIn
    root :to => redirect("/sign_in")


    patch 'set_locale', to: 'locale#set_locale'
  end





end
