Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  get 'admin', to: 'posts#admin'
  resources :posts
  resources :index_parts
  get 'drafts', to: 'posts#draft_index'
  get '/about', to: 'static_pages#about'
  get '/side-projects', to: 'static_pages#side_projects'
  get '/portfolio', to: 'positions#portfolio'
  get '/indices', to: 'indices#indexes'

  post 'subscriber-signup', to: 'posts#subscriber_signup'
  post 'subscriber-signup', to: 'static_pages#subscriber_signup'
  post 'subscriber-signup', to: 'positions#subscriber_signup'
  post 'subscriber-signup', to: 'application#subscriber_signup'
  post 'subscriber-signup', to: 'index_parts#subscriber_signup'

end
