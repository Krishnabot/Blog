Rails.application.routes.draw do
  devise_for :admins, path: "admins"

  namespace :api do
    namespace :v1 do
      resources :articles, only: [:index, :show], param: :slug
      devise_scope :admin do
        post   "admin/sign_in",  to: "admins/sessions#create"
        delete "admin/sign_out", to: "admins/sessions#destroy"
      end
      namespace :admin do
        resources :articles, except: [:new, :edit]
      end
    end
  end
end
