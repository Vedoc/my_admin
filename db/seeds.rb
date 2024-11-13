# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create default admin user
AdminUser.create!(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password'
) if Rails.env.development? && AdminUser.count.zero?

# For production environment, use environment variables
if Rails.env.production? && AdminUser.count.zero?
  AdminUser.create!(
    email: ENV['ADMIN_EMAIL'] || 'admin@example.com',
    password: ENV['ADMIN_PASSWORD'] || 'password',
    password_confirmation: ENV['ADMIN_PASSWORD'] || 'password'
  )
end
  