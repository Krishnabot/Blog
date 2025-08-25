require "json"

def parse_origins(raw)
  return ["*"] if raw.nil? || raw.strip.empty?
  s = raw.strip
  if s.start_with?("[") 
    JSON.parse(s)
  elsif s.include?(",") 
    s.split(",").map(&:strip)
  else                  
    s.split(/\s+/)
  end
end

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins(*parse_origins(ENV["FRONTEND_ORIGINS"]))
    resource "/api/*",
      headers: :any,
      expose: ["Content-Range", "Authorization"], 
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
