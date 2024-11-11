class ActiveAdmin::BaseController
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: :devise_controller?
end

class ActiveAdmin::Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: [:create]
end
