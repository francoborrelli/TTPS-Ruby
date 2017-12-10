class LocaleController < ApplicationController

    def set_locale
        if (params[:lang])
          lang = params[:lang]
          raise 'unsupported locale' unless ['es-AR', 'en'].include?(lang)
          cookies[:lang] = lang
        end
        redirect_back fallback_location: root_path
    end
  
end  