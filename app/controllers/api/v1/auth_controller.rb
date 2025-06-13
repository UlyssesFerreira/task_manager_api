module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authorize_request

      def login
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          expiration = Time.now.to_i + 1.day.seconds
          payload = {
            data: user.id,
            exp: expiration
          }
          token = JWT.encode(payload, Rails.application.credentials.secret_key_base)
          render json: { access_token: token, expires_at: Time.at(expiration) }
        else
          render json: { error: "Invalid credentials" }, status: :unauthorized
        end
      end
    end
  end
end
