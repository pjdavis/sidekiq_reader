# frozen_string_literal: true

module SidekiqReader
  module ResponseMapping
    class Retries
      ##
      # Gets array of arrays of [name, size, latency, actions] from /queues
      def self.list_parser
        lambda do |doc|
          doc.css('table.table>tr').map do |tr|
            line = []
            tr.css('td').each_with_index do |td, index|
              next if index.zero?

              line << case index
                      when 1
                        td.css('time').text.strip
                      else
                        td.text.strip
                      end
            end
            line
          end
        end
      end
    end
  end
end
