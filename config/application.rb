require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine" 
Bundler.require(*Rails.groups)

module BancoApi
  class Application < Rails::Application 
    config.load_defaults 8.0
    config.eager_load_paths << Rails.root.join('lib')
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/app/filters)
    config.autoload_paths += %W(#{config.root}/app/controllers/concerns)
    config.autoload_paths << "#{config.root}/app/filters"
    config.autoload_paths << "#{config.root}/app/services" 
    config.autoload_lib(ignore: %w[assets tasks])
 
    config.api_only = true
  end
end
