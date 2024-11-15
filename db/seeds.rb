# This file ensures the existence of required records across all environments.
# It is idempotent and can be executed multiple times safely.

puts "Starting seed process..."

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
  admin_email = 'arnoldn@vedocapp.com'
  admin_password = 'password1998'

  begin
    admin = AdminUser.create!(
      email: admin_email,
      password: admin_password,
      password_confirmation: admin_password
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
  