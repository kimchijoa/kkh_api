require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module VideoProjectRestApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    #add for grape gem
    # config.paths.add File.join(‘app’, ‘api’), glob: File.join(‘**’, ‘*.rb’)
    # config.autoload_paths += Dir[Rails.root.join(‘app’, ‘api’, ‘*’)]

    #API
    # config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    # config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]
    # config.paths.add "app/api/api", glob: "**/*.rb"
    # config.autoload_paths += Dir["#{Rails.root}/app/api/api/*"]
    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
