class ErrorsController < ApplicationController
  def not_found
    render(:error, locals: { code: 404, message: :not_found }, status: 404)
  end

  def internal_server_error
    render(:error, locals: { code: 500, message: :server_error }, status: 500)
  end
end
