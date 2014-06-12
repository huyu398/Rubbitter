module Rubbitter
  module Interface
    class AuthenticationDialogController
      include JRubyFX::Controller
      fxml 'authentication_dialog.fxml'

      def button_clicked
        @ok_button.scene.window.hide
      end
    end
  end
end
