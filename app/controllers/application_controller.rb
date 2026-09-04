class ApplicationController < ActionController::Base
  respond_to :json
  skip_before_action :verify_authenticity_token, raise: false

  before_action :track_visit, if: :user_signed_in?
  private

 def authenticate_user!
    return if current_user

    render json: { error: "You need to sign in first." }, status: :unauthorized
  end

  def track_visit
    return if current_user.last_visited_at&.today?

    current_user.update_column(:last_visited_at, Time.current)
  end
end
