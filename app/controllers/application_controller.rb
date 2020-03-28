class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?

    helper_method :curr_user
    helper_method :admin

    protected

    def curr_user
      @curr_user ||= User.find_by(session_token: session[:session_token])
    end

    

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :date_of_birth, :phone_number, :address, :name_on_card, :expiry_date, :cvv, :email, :password, :password_confirmation])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :date_of_birth, :phone_number, :address, :name_on_card, :expiry_date, :cvv, :email, :password, :password_confirmation, :current_password])
    end    
end