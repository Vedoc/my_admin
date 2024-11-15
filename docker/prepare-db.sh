#!/bin/sh

echo "Starting database preparation..."

# Function to check if database exists
check_db() {
  psql -h $DB_HOST -U $DB_USER -d $DB_NAME -c '\q' 2>/dev/null
  return $?
}

# Function to check if migrations are pending
check_migrations() {
  bundle exec rake db:migrate:status | grep -q "down"
  return $?
}

# Main logic
if check_db; then
  echo "Database exists, checking for pending migrations..."
  
  if check_migrations; then
    echo "Running pending migrations..."
    bundle exec rake db:migrate
  else
    echo "No pending migrations"
  fi
else
  echo "Database does not exist, running setup..."
  bundle exec rake db:setup
fi

echo "Running seeds to ensure required data..."
bundle exec rake db:seed

echo "Database preparation completed!"
