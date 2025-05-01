Rails.application.routes.draw do
  devise_for :admins

  # Public routes under readers namespace
  namespace :readers do
    resources :blog_posts, only: [:index, :show]
  end

  # Admin routes
  namespace :admin do
    resources :blog_posts, only: [:new, :create, :edit, :update, :destroy]
  end

  # Root to public blog posts index
  root "readers/blog_posts#index"
end