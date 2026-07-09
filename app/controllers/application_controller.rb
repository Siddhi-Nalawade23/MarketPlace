class ApplicationController < ActionController::Base
  respond_to :json
  skip_before_action :verify_authenticity_token, raise: false

  private

  def authenticate_user!
    if request.headers["Authorization"].blank?
      render json: { error: "You need to sign in first." }, status: :unauthorized
    else
      super
    end
  end
end
