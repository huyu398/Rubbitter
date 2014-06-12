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
        begin
          access_token = @request_token.get_access_token(oauth_verifier: @pin_field.text)
        rescue OAuth::Unauthorized
          show_dialog
          return @pin_field.clear
        end
        token_hash = { token: { access_token: access_token.token, access_token_secret: access_token.secret } }
        Rubbitter::Config.make_config_file(token_hash)
        Platform.exit
      end

      private

      # [todo] - Refactoring, this is seemed like java code...
      def show_dialog
        error_dialog = Stage.new(StageStyle::UTILITY)
        Rubbitter::Interface::AuthenticationDialogController.load_into(error_dialog)
        error_dialog.initOwner(@pin_field.scene.window)
        error_dialog.init_modality = Modality::WINDOW_MODAL
        error_dialog.resizable = false
        error_dialog.title = 'Unauthorized error'
        error_dialog.show_and_wait
      end
    end
  end
end
