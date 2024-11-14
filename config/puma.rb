# This configuration file will be evaluated by Puma. The top-level methods that
# are invoked here are part of Puma's configuration DSL. For more information
# about methods provided by the DSL, see https://puma.io/puma/Puma/DSL.html.

# Puma can serve each request in a thread from an internal thread pool.
workers ENV.fetch("WEB_CONCURRENCY") { 2 }
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

# Specify the port puma will listen on
port ENV.fetch("PORT") { 3001 }

# Specify the environment it will run in
environment ENV.fetch("RAILS_ENV") { "development" }

# Bind to all network interfaces
bind "tcp://0.0.0.0:#{ENV.fetch("PORT") { 3001 }}"

# Allow puma to be restarted by `rails restart` command
plugin :tmp_restart
