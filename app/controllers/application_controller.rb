class ApplicationController < ActionController::Base

  before_action :authenticate_user!

  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?
  

  before_action :set_timezone

  before_action :set_paper_trail_whodunnit


  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:timezone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:timezone])
  end

  def set_timezone
    if user_signed_in? && current_user.timezone.present?
      case current_user.timezone
      when 'India'
        Time.zone = 'Asia/Kolkata'
      when 'USA'
        Time.zone = 'America/New_York' # Example: East Coast Time
      when 'London'
        Time.zone = 'Europe/London'
      when 'Australia'
        Time.zone = 'Australia/Sydney'
      else
        Time.zone = 'UTC'
      end
    else
      Time.zone = 'UTC'
    end
  end

end
