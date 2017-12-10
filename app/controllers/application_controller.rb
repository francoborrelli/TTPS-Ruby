class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_language

  def set_language
    I18n.locale = cookies[:language]
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end
