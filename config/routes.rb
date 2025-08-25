Rails.application.routes.draw do
  devise_for :admins,
    path: "admins",
    controllers: { sessions: "admins/sessions" }
  namespace :admins do
    get "dashboard", to: "dashboard#index"
    resources :blog_posts, except: [:index, :show] 
  end


  namespace :api do
    namespace :v1 do
      devise_scope :admin do
        post   "admin/sign_in",  to: "admins/sessions#create"
        delete "admin/sign_out", to: "admins/sessions#destroy"
      end

      resources :articles, only: [:index, :show], param: :slug

      namespace :admin do
        resources :articles, except: [:new, :edit], param: :id
      end
    end
  end
end
