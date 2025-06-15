class ApplicationController < ActionController::API
  before_action :authorize_request
  before_action :set_paper_trail_whodunnit

  def current_user
    @current_user
  end

  private

  def authorize_request
    header = request.headers["Authorization"]
    token = header.split(" ").last if header
    decoded = JsonWebToken.decode(token)
    @current_user = User.find(decoded[:data])
  rescue => e
    render json: { error: e.message }, status: :unauthorized
  end
end
