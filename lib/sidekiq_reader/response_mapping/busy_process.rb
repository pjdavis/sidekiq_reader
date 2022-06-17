# frozen_string_literal: true

module SidekiqReader
  module ResponseMapping
    class BusyProcess
      ##
      #
      def self.list_parser
        lambda do |doc|
          resp = []
          doc.css('.processes>tr').each do |tr|
            line = []
            tr.css('td').each_with_index do |td, index|
              case index
              when 0
                next if td.children[0].nil?

                process = [td.children[0].text.strip]
                process << td.children[1].text.strip
                line << process
                line << td.children[6].text.strip
              when 1
                line << td.css('time').text.strip
              when 5
                line << ''
              else
                line << td.text.strip
              end
            end
            resp << line
          end
          resp
        end
      end
    end
  end
end
