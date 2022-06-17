# frozen_string_literal: true

module SidekiqReader
  module ResponseMapping
    class Queue
      ##
      # Gets array of arrays of [name, size, latency, actions] from /queues
      def self.list_parser
        lambda do |doc|
          doc.css('.queues>tr').map { |tr| tr.css('td').map { |td| td.text.strip } }
        end
      end
    end
  end
end
