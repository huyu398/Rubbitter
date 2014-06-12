require 'jrubyfx'

module Rubbitter
  module Interface
    class AuthenticationApp < JRubyFX::Application
      def start(stage)
        with(stage, title: 'Authetication') do
          fxml 'authentication.fxml'
          show
        end
      end
    end
  end
end
