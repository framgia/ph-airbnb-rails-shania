class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  add_flash_types :success, :info, :warning, :error
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_global_search_variable

  def set_global_search_variable
    @search = Property.ransack(params[:q])
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :phonenumber, :description, :password, :current_password)}
    end
end