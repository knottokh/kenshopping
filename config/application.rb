require File.expand_path('../boot', __FILE__)


require "active_storage"
require 'rails/all'
require "spree"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Workspace
  class Application < Rails::Application
    
    config.load_defaults 5.2
    
    config.to_prepare do
      # Load application's model / class decorators
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      # Load application's view overrides
      Dir.glob(File.join(File.dirname(__FILE__), "../app/overrides/*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    
    #map vinsol_spree_themes assets
    config.assets.paths << Rails.root.join("public", "vinsol_spree_themes/current", "fonts")
    #config.assets.paths << Rails.root.join("public", "vinsol_spree_themes/current", "images")
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.load_path += Dir[Rails.root.join('public', 'vinsol_spree_themes/current/locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :th

    # Do not swallow errors in after_commit/after_rollback callbacks.
    #config.active_record.raise_in_transactional_callbacks = true
    config.active_storage.service = :local
    
    config.time_zone = "Asia/Bangkok"
    
    config.exception_handler = { 
      dev: true ,
      exceptions: {
        all: { layout: nil } # -> this will inherit from ApplicationController's layout
      }
    }
  end
end
