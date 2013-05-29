require 'rack/reverse_proxy'

Rails.application.config.middleware.insert_before Rack::Cache, Rack::ReverseProxy do
  # Forward the path /test* to http://example.com/test*
  reverse_proxy '/arrowchat', 'http://localhost/'
end

