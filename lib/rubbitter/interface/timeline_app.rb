require 'jrubyfx'

module Rubbitter
  module Interface
    class TimelineApp < JRubyFX::Application
      def start(stage)
        with(stage, title: 'Rubbiter') do
          fxml Rubbitter::Interface::TimelineController
          show
        end
      end
    end
  end
end
