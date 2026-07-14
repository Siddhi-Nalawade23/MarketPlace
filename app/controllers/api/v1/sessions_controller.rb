class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :verify_authenticity_token, raise: false
  skip_before_action :require_no_authentication, raise: false

  private

  def respond_with(resource, _opts = {})
    render json: {
      message: "Logged in successfully",
      user: { id: resource.id, email: resource.email, name: resource.name, role: resource.role }
    }, status: :ok
  end

  def respond_to_on_destroy
    render json: { message: "Logged out successfully" }, status: :ok
  end
end
