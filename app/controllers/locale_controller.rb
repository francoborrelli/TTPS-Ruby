class LocaleController < ApplicationController
  def set_locale
    if params[:language]
      raise('unsupported locale') unless ['es-AR', 'en'].include?(params[:language])
      cookies.permanent[:language] = params[:language]
    end
    redirect_to(request.referer || root_path)
  end
end
