source "https://rubygems.org"
git_source( :github ) { | repo | "https://github.com/#{ repo }.git" }

# ruby "3.3.1"
ruby '3.3.0'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
# gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem 'rails', '~> 7.1.3.2'

# Vedoc app models
# gem 'vedoc-plugin', git: 'https://github.com/vedoc/vedoc-plugin.git'
gem 'vedoc-plugin', git: 'https://github.com/vedoc/vedoc-plugin.git'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# ActiveRecord connection adapter for PostGIS, based on postgresql and rgeo
gem 'activerecord-postgis-adapter'

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.2.1'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use SCSS for stylesheets
gem 'sass-rails'
gem 'sassc'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'

# Solution for file uploads
gem 'carrierwave'

# UI interface for rails-settings-cached in active admin
# agem 'activeadmin_settings_cached', '>= 2.3.1'


# Ruby bindings to Firebase Cloud Messaging
gem 'fcm'

# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Ruby static code analyzer and code formatter
  gem 'rubocop', require: false
  # Shim to load environment variables from .env into ENV in development
  gem 'dotenv-rails'
  # An alternative to the standard IRB shell for Ruby.
  gem 'pry-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end

gem "devise", "~> 4.9"

gem "activeadmin", "~> 3.2"

gem "rexml", ">= 3.2.7"



gem "nokogiri", ">= 1.16.5"

gem 'inherited_resources'