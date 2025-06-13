module AuthHelpers
  def auth_header(user)
    token = JWT.encode({ data: user.id, exp: Time.now.to_i + 1.day.seconds }, ENV.fetch("JWT_SECRET"))
    { "Authorization" => "Bearer #{token}" }
  end
end

RSpec.configure do |config|
  config.include AuthHelpers
end
