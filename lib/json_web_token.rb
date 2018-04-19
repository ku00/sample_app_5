require 'openssl'

class JsonWebToken
  ALGORITHM = 'HS256'
  SECTET_KEY = "8a64f7475ccb714456f6af736b9acc40dce461e59f146634f2c76621d3f48e4d"

  class << self
    def encode(payload, expire = 1.day)
      payload[:exp] = Time.current.to_i + expire.to_i

      JWT.encode(payload, SECTET_KEY, ALGORITHM)
    end

    def decode(token)
      payload, _ = JWT.decode(
        token,
        SECTET_KEY,
        true,
        { algorithm: ALGORITHM }
      )

      payload
    rescue JWT::ExpiredSignature
      {}
    end
  end
end