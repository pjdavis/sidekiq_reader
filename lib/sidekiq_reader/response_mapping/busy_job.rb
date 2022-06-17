# frozen_string_literal: true

module SidekiqReader
  module ResponseMapping
    class BusyJob
      ##
      #
      def self.list_parser
        lambda do |doc|
          doc.css('.workers>tr').map do |tr|
            tr.css('td').map.with_index do |td, index|
              case index
              when 3
                td.css('a').text.strip
              when 5
                td.css('div').text.strip
              when 6
                td.css('time').text.strip
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
