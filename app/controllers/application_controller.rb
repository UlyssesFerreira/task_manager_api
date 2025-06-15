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
    begin
      decoded = JWT.decode(token, ENV.fetch("JWT_SECRET"))[0]
      @current_user = User.find(decoded["data"])
    rescue JWT::ExpiredSignature
      render json: { error: "Expired token" }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { error: "Invalid token" }, status: :unauthorized
    end
  end
end
