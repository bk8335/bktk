Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  get 'admin', to: 'posts#admin'
  resources :posts
  get '/about', to: 'static_pages#about'
  get '/side-projects', to: 'static_pages#side_projects'

  post 'subscriber-signup-post', to: 'posts#subscriber_signup'
  post 'subscriber-signup-static', to: 'static_pages#subscriber_signup'
end
