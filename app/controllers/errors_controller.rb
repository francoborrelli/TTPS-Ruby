class ErrorsController < ApplicationController
  def not_found
    render_error(404, :not_found)
  end

  def internal_server_error
    render_error(500, :server_error)
  end

  private

  def render_error(code, message)
    render(:error, locals: { code: code, message: message }, status: code)
  end
end
