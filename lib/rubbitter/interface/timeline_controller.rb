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

        timeline_array = client.home_timeline
        timeline_array.map! do |t|
          { icon: t.user.profile_image_url.to_s, text: t.text }
        end
        # [todo] - I don't really know why it don't work
        # @timeline.scroll_pane.hbar_policty(ScrollPane::ScrollBarPolicy::NEVER)
        @timeline.items = FXCollections.observable_list(timeline_array)
        @timeline.cell_factory = proc { Rubbitter::Interface::TweetCell.new }
      end
    end
  end
end
