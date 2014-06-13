require 'jrubyfx'
require 'yaml'

# [todo] - This should be written in bin/rubbitter.
# [review] - If the good way than following exist, it should be replaced.
LINUX_FLAG = (RbConfig::CONFIG['host_os'] == 'linux') ? true : false

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

      def show_dialog
        @error_dialog = stage(StageStyle::UTILITY, title: 'Unauthorized error', resizable: false)
        unresizable_on_linux if LINUX_FLAG
        Rubbitter::Interface::AuthenticationDialogController.load_into(@error_dialog)
        @error_dialog.init_owner(@pin_field.scene.window)
        @error_dialog.init_modality = Modality::WINDOW_MODAL
        @error_dialog.show_and_wait
      end

      # I can't set that resizable is false.
      # It may cause [this](http://stackoverflow.com/questions/17816682/why-disabling-of-stage-resizable-dont-work-in-javafx).
      def unresizable_on_linux
        @error_dialog.max_height = 158
        @error_dialog.max_width = 504
        @error_dialog.min_height = 158
        @error_dialog.min_width = 504
      end
    end
  end
end
