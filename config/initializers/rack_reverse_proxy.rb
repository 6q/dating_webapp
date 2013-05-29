require 'rack/reverse_proxy'

Rails.application.config.middleware.insert_before Rack::Cache, Rack::ReverseProxy do
  # Forward the path /arrowchat* to http://example.com/localhost*
  reverse_proxy '/arrowchat', "http://#{ENV.fetch('ARROWCHAT_HOST', 'localhost')}/"
end

