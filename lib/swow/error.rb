module Swow
  module Error
    class RessourceNotFound < ::Faraday::ResourceNotFound

      def self.raise_ressource_not_found(response)
        if nok?(response)
          case response[:body]['reason']
          when 'Character not found.'
            raise CharacterNotFound, response
          when 'Realm not found.'
            raise RealmNotFound, response
          end
        end
        raise ResourceNotFound, response
      end

      def reason
        @response[:body]['reason']
      end

      def self.nok?(response)
        response[:body].respond_to?(:each_key) && response[:body]['status'] == 'nok'
      end
    end

    class CharacterNotFound < RessourceNotFound; end
    class RealmNotFound < RessourceNotFound; end

    class RaiseError < Faraday::Response::Middleware
      ClientErrorStatuses = 400...600

      def on_complete(env)
        case env.status
        when 404
          RessourceNotFound.raise_ressource_not_found(response_values(env))
        when ClientErrorStatuses
          raise Faraday::Error::ClientError, response_values(env)
        end
      end

      def response_values(env)
        { status: env.status, headers: env.response_headers, body: env.body }
      end
    end

    Faraday::Response.register_middleware battlenet_errors: RaiseError
  end
end
