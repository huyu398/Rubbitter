require 'jrubyfx'
require 'yaml'

module Rubbitter
  module Interface
    class AuthenticationController
      include JRubyFX::Controller
      fxml 'authentication.fxml'

      def initialize
        consumer = OAuth::Consumer.new(
          Rubbitter::CONSUMER_KEY,
          Rubbitter::CONSUMER_SECRET,
          site: 'https://api.twitter.com'
        )

        @request_token = consumer.get_request_token
        @oauth_web.engine.load(@request_token.authorize_url)
      end

      def pin_entered
        access_token = @request_token.get_access_token(oauth_verifier: @pin_field.text)
        token_hash = { token: { access_token: access_token.token, access_token_secret: access_token.secret } }
        Rubbitter::Config.make_config_file(token_hash)
        Platform.exit
      end
    end
  end
end
