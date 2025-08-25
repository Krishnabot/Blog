
class Api::V1::Admins::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :verify_authenticity_token

  private

  def respond_with(resource, _opts = {})
    render json: { id: resource.id, email: resource.email }
  end

  def respond_to_on_destroy
    head :no_content
  end
end
