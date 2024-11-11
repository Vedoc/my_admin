ActiveAdmin::BaseController.class_eval do
  protect_from_forgery with: :exception
  
  skip_before_action :verify_authenticity_token, if: :devise_controller?
end
