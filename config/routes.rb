Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions' }

  resources :blog_posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  root "blog_posts#index"
end