class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!, except: [:set_locale]
  before_action :set_language

  def set_language
    I18n.locale = cookies[:language]
  end

  def not_found
    raise(ActionController::RoutingError, 'Not Found')
  end
end
