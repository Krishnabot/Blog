Rails.application.routes.draw do
  devise_for :admins # Remove custom sessions controller for now

  # Public routes
  resources :blog_posts, only: [:index, :show]

  # Admin routes
  namespace :admin do
    resources :blog_posts, only: [:new, :create, :edit, :update, :destroy]
  end

  root "blog_posts#index"
end