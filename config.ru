# This file is used by Rack-based servers to start the application.
require_relative 'config/environment'
require 'rack/cors'

use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: [:get, :post, :options, :put, :delete]
    end
end

run V1::Books
run Rails.application
