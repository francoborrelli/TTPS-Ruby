class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!, except: [:set_locale, :not_found, :internal_server_error]
  before_action :set_language

  def set_language
    I18n.locale = cookies[:language]
  end

  def check_pagination(objects)
    not_found if objects.empty? && params[:page]
  end

  def not_found
    redirect_to(not_found_path)
  end
  
  def internal_server_error
    redirect_to(internal_error_path)
  end
end
