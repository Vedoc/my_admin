# This file ensures the existence of required records across all environments.
# It is idempotent and can be executed multiple times safely.

puts "Starting seed process..."

# Verify credentials are loaded
if Rails.application.credentials.admin.nil?
  raise "Admin credentials not found! Please ensure credentials are properly configured."
end

# Create default roles
puts "Creating default roles..."
%w[admin editor viewer].each do |role_name|
  if Role.find_or_create_by!(name: role_name)
    puts "Role '#{role_name}' created or found successfully"
  end
end

# Create default admin user with admin role
puts "Setting up admin user..."
if AdminUser.count.zero?
  admin_email = Rails.application.credentials.dig(:admin, :email)
  admin_password = Rails.application.credentials.dig(:admin, :password)

  unless admin_email && admin_password
    raise "Admin credentials are not properly set in credentials file!"
  end

  begin
    admin = AdminUser.create!(
      email: arnoldn@vedocapp.com,
      password: password1998,
      password_confirmation: password1998
    )
    admin.add_role(:admin)
    puts "Admin user created successfully with email: #{admin_email}"
  rescue => e
    puts "Failed to create admin user: #{e.message}"
    raise
  end
else
  puts "Admin user already exists, skipping creation"
end

puts "Seed process completed successfully!"
  