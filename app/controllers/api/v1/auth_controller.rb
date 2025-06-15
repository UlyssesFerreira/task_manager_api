module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authorize_request

      def login
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          payload = { data: user.id }
          token = JsonWebToken.encode(payload)
          render json: { access_token: token, expires_at: 24.hours.from_now }
        else
          render json: { error: "Invalid credentials" }, status: :unauthorized
        end
      end
    end
  end
end
