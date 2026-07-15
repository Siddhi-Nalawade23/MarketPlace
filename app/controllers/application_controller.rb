class ApplicationController < ActionController::Base
  respond_to :json
  skip_before_action :verify_authenticity_token, raise: false

  before_action :track_visit, if: :user_signed_in?
  private

  def authenticate_user!
    if request.headers["Authorization"].blank?
      render json: { error: "You need to sign in first." }, status: :unauthorized
    else
      super
    end
  end
   def track_visit
    return if current_user.last_visited_at&.today?
    current_user.update_column(:last_visited_at, Time.current)
  end
end
