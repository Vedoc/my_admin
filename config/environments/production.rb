require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available.
  config.require_master_key = true

  # Static file serving configuration
  config.public_file_server.enabled = true

  # Asset compilation settings
  config.assets.compile = true
  config.assets.digest = true
  config.assets.js_compressor = nil  # Temporarily disable JS compression
  config.assets.css_compressor = :sass
  config.assets.precompile += %w( active_admin.css active_admin.js application.css application.js )

  # Store uploaded files on the local file system
  config.active_storage.service = :local

  # SSL Configuration
  config.force_ssl = true

  # Logging configuration
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.log_tags = [ :request_id ]
  config.logger = ActiveSupport::Logger.new(STDOUT)
  config.log_formatter = ::Logger::Formatter.new

  # Action Mailer Configuration
  config.action_mailer.perform_caching = false
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    user_name: ENV['MAIL_USERNAME'],
    password: ENV['MAIL_PASSWORD'],
    domain: ENV['APP_HOST'],
    address: ENV['SMTP_DOMAIN'],
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }

  # Enable locale fallbacks for I18n
  config.i18n.fallbacks = true

  # Don't log any deprecations.
  config.active_support.report_deprecations = false

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.asset_host = "http://assets.example.com"

  # Compress CSS using a preprocessor
  config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.asset_host = "http://assets.example.com"

  # Compress JavaScripts and CSS
  config.assets.js_compressor = nil  # Temporarily disable JS compression

  # Generate digests for assets URLs
  config.assets.digest = true

  # Version of your assets
  config.assets.version = '1.0'
end
