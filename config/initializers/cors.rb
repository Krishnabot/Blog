Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV.fetch("FRONTEND_ORIGIN", "*") 
    resource "/api/*",
      headers: :any,
      methods: [:get, :post, :patch, :put, :delete, :options],
      expose: ["Authorization"]
  end
end
