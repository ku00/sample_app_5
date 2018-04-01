require 'openssl'

class JsonWebToken
  ALGORITHM = 'RS256'

  class << self
    def encode(payload, expire = 10.seconds)
      payload[:exp] = Time.current.to_i + expire.to_i

      JWT.encode(payload, rsa_private, ALGORITHM)
    end

    def decode(token)
      payload, _ = JWT.decode(
        token,
        rsa_private.public_key,
        true,
        { algorithm: ALGORITHM }
      )

      payload
    rescue JWT::ExpiredSignature
      {}
    end

    private

      def rsa_private
        OpenSSL::PKey::RSA.new(ENV['JWT_PRIVATE_KEY'])
      end
  end
end