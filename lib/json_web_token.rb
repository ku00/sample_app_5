require 'openssl'

class JsonWebToken
  ALGORITHM = 'RS256'

  class << self
    def encode(payload, expire = 1.days)
      payload[:expire] = expire.to_i

      JWT.encode(payload, rsa_private, ALGORITHM)
    end

    def decode(token)
      JWT.decode(
        token,
        rsa_private.public_key,
        true,
        { algorithm: ALGORITHM }
      )
    end

    private

      def rsa_private
        OpenSSL::PKey::RSA.new(ENV['JWT_PRIVATE_KEY'])
      end
  end
end