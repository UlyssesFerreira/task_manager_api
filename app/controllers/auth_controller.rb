class AuthController < ApplicationController
  def login
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      expiration = Time.now.to_i + 120
      payload = {
        data: user.id,
        exp: expiration
      }
      token = JWT.encode(payload, Rails.application.credentials.secret_key_base)
      render json: { access_token: token, expires_at: Time.at(expiration) }
    else
      render json: { error: "Invald credentials" }, status: :unauthorized
    end
  end
end
