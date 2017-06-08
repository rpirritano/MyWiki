class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  
  #before_action :authenticate_user!, except: [:home, :about, :contact]

#helpers
#user_signed_in?, current_user, user_session


protected
def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email])
  devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation]) 
  devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation, :current_password])
end
#devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
 # devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  #devise_parameter_sanitizer.permit(:account_update, keys: [:name])

end
