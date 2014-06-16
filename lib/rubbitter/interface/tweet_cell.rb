require 'jrubyfx'

module Rubbitter
  module Interface
    class TweetCell < Java.javafx.scene.control::ListCell
      include JRubyFX::DSL

      # rubocop:disable Style/MethodName
      def updateItem(tweet, empty)
        super(tweet, empty)
        return if empty
        set_graphic(tweet_cell_design(tweet[:icon], tweet[:text]))
      end

      private

      def tweet_cell_design(icon, text)
        @icon = icon_design(icon)
        @text = label(text)
        anchor_set
        tweet_cell = anchor_pane
        tweet_cell.children.add_all(@icon, @text)
        tweet_cell
      end

      def icon_design(icon)
        image_view(
          image(icon),
          fit_height: 50.0, fit_width: 50.0,
          layout_x: 14.0, layout_y: 14.0
        )
      end

      def text_design(text)
        label(
          text,
          alignment: Java.javafx.geometry.Pos::TOP_LEFT,
          wrap_text: true,
          pref_height: 50.0, pref_width: 510.0,
          layout_x: 70.0, layout_y: 15.0
        )
      end

      def anchor_set
        AnchorPane.setBottomAnchor(@icon, 15.0)
        AnchorPane.setLeftAnchor(@icon, 15.0)
        AnchorPane.setRightAnchor(@icon, 485.0)
        AnchorPane.setTopAnchor(@icon, 15.0)
        AnchorPane.setBottomAnchor(@text, 15.0)
        AnchorPane.setLeftAnchor(@text, 75.0)
        AnchorPane.setRightAnchor(@text, 15.0)
        AnchorPane.setTopAnchor(@text, 15.0)
      end
    end
  end
end
