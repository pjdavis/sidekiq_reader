# frozen_string_literal: true

module SidekiqReader
  module ResponseMapping
    class Enqueued
      ##
      #
      def self.list_parser
        lambda do |doc|
          doc.css('.queue>tr').map do |tr|
            tr.css('td').map.with_index do |td, index|
              if index == 2 && !td.css('div').empty?
                td.css('div').text.strip
              else
                td.text.strip
              end
            end
          end
        end
      end
    end
  end
end
