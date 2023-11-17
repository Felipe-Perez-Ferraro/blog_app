class ApplicationController < ActionController::Base
    # Must be disable for API applications.
    protect_from_forgery with: :exception
    before_action :update_allowed_parameters, if: :devise_controller?
    before_action :authenticate_user!
  
    protected
  
    def update_allowed_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |u|
        u.permit(:name, :photo, :bio, :email, :password, :password_confirmation)
      end
      devise_parameter_sanitizer.permit(:account_update) do |u|
        u.permit(:name, :photo, :bio, :email, :password, :current_password)
      end
    end
end
