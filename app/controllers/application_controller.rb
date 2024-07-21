class ApplicationController < ActionController::API
  def require_user
    render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user
  end

  private

  def current_user
    @current_user ||= User.find_by(api_token: params[:api_token])
  rescue Mongoid::Errors::DocumentNotFound => e
    @current_user = nil
  end
end
