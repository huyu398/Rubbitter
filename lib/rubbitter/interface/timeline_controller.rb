require 'jrubyfx'
require 'twitter'

module Rubbitter
  module Interface
    class TimelineController
      include JRubyFX::Controller
      fxml 'timeline.fxml'

      def initialize
        client = Twitter::REST::Client.new do |c|
          token = CONFIG.property[:token]
          c.consumer_key        = Rubbitter::CONSUMER_KEY
          c.consumer_secret     = Rubbitter::CONSUMER_SECRET
          c.access_token        = token[:access_token]
          c.access_token_secret = token[:access_token_secret]
        end

        p client.home_timeline
      end
    end
  end
end
