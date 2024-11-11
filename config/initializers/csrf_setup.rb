if defined?(ActiveAdmin)
  ActiveAdmin::Devise::SessionsController.class_eval do
    skip_before_action :verify_authenticity_token, only: [:create]
  end
end
