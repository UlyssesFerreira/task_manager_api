module AuthHelpers
  def auth_header(user)
    payload = { data: user.id }
    token = JsonWebToken.encode(payload)
    { "Authorization" => "Bearer #{token}" }
  end
end

RSpec.configure do |config|
  config.include AuthHelpers
end
