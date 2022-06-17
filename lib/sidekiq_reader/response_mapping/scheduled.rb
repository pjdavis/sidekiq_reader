# frozen_string_literal: true

module SidekiqReader
  module ResponseMapping
    class Scheduled
      def self.list_parser
        lambda do |doc|
          doc.css('.table>tr').map do |tr|
            line = []
            tr.css('td').each_with_index do |td, index|
              case index
              when 0
                next
              when 1
                line << td.css('time').text.strip
              when 2
                line << td.css('a').text.strip
              when 4
                line << td.css('div').text.strip
              else
                line << td.text.strip
              end
            end
            line
          end
        end
      end
    end
  end
end
