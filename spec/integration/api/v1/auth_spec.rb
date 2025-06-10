require "swagger_helper"

RSpec.describe "Authentication", type: :request do
  path "/api/v1/login" do
    post("Authenticate user and returns a access token") do
      tags "Authentication"
      consumes "application/json"
      produces "application/json"

      # Define os parâmetros de entrada que o endpoint espera (nesse caso 'credentials')
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: "user@example.com" },
          password: { type: :string, example: "123123" }
        },
        required: [ "email", "password" ]
      }

      response "200", "valid credentials" do
        let!(:user) { create(:user, password: "123456") }
        let(:credentials) { { email: user.email, password: "123456" } }

        # Define o formato da resposta esperada em JSON
        schema type: :object,
          properties: {
            access_token: { type: :string },
            expires_at: { type: :string, format: :date_time }
          },
          required: [ "access_token", "expires_at" ]

        run_test!
      end

      response "401", "invalid credentials" do
        let(:credentials) { { email: "wrong@example.com", password: "wrong123" } }

        schema type: :object,
          properties: {
            error: { type: :string }
          },
          required: [ "error" ]

        run_test!
      end
    end
  end
end
