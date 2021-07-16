module API
  module V1
    class Base < Grape::API
      # prefix 'api'
      mount V1::Base
      # mount API::V1::AnotherResource
    end
  end
end