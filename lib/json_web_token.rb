class JsonWebToken
  ALGORITHM = 'RS256'

  class << self
    def encode(payload, expire = 1.days)
      payload[:expire] = expire.to_i

      JWT.encode(payload, ENV['JWT_PRIVATE_KEY'], ALGORITHM)
    end

    def decode(token)
      body = JWT.decode(token, ENV['JWT_PUBLIC_KEY'], true, { algorithm: ALGORITHM })
    end
  end
end