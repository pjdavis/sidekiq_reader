# frozen_string_literal: true

module SidekiqReader
  module ResponseMapping
    class Count
      def self.list_parser
        lambda do |doc|
          list = []
          list << doc.css('.list-unstyled.summary.row>li').map do |li|
            li.css('span.count').first.text.strip
          end
          list
        end
      end
    end
  end
end
