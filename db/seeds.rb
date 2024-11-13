# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create default roles
%w[admin editor viewer].each do |role_name|
  Role.find_or_create_by!(name: role_name)
end

# Create default admin user with admin role
if AdminUser.count.zero?
  admin = AdminUser.create!(
    email: ENV['ADMIN_EMAIL'] || 'arnoldnek@gmail.com',
    password: ENV['ADMIN_PASSWORD'] || 'password123',
    password_confirmation: ENV['ADMIN_PASSWORD'] || 'password123'
  )
  admin.add_role(:admin)
end
  