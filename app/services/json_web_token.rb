class JsonWebToken
  SECRET_KEY = ENV.fetch("JWT_SECRET")

  def self.encode(payload, expiration = 24.hours.from_now)
    payload[:exp] = expiration.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded)
  rescue JWT::ExpiredSignature
    raise "Expired token"
  rescue JWT::DecodeError => e
    raise "Invalid token: #{e.message}"
  end
end
