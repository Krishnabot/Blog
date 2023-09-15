Rails.application.routes.draw do
  get "/blog_posts/:id", to: "blog_posts#show", as: :blog_post
  root "blog_posts#index"
end
