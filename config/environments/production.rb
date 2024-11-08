require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Allow the specified hosts first thing
  config.hosts = nil  # This disables the host check completely
  config.hosts = [
    "100-25-145-224.nip.io",
    "100.25.145.224"
  ]

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available in ENV["RAILS_MASTER_KEY"], 
  # config/master.key, or an environment key such as config/credentials/production.key
  config.require_master_key = true

  # Static file serving configuration
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  
  # Compress CSS using a preprocessor.
  config.assets.css_compressor = :sass

  # Asset compilation settings
  config.assets.compile = true
  config.assets.digest = true
  config.assets.precompile += %w( active_admin.scss application.css active_admin.js )

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = "http://assets.example.com"

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for Apache
  config.action_dispatch.x_sendfile_header = "X-Accel-Redirect" # for NGINX

  # Store uploaded files on the local file system
  config.active_storage.service = :local

  # Mount Action Cable outside main process or domain.
  # config.action_cable.mount_path = nil
  # config.action_cable.url = "wss://example.com/cable"
  # config.action_cable.allowed_request_origins = [ "http://example.com", /http:\/\/example.*/ ]

  # SSL Configuration
  config.assume_ssl = true
  config.force_ssl = true

  # Logging configuration
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.log_tags = [ :request_id ]
  
  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Log to STDOUT by default
  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

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

  # Clean up conflicting static file configurations
  # Remove deprecated settings
  # config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?
  # config.serve_static_assets = true

  # Enable DNS rebinding protection and other Host header attacks.
  # Skip DNS rebinding protection for the default health check endpoint.
  config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
end
