# frozen_string_literal: true

module SidekiqReader
  class Table
    def initialize(columns, data)
      @columns = columns
      @data = data
      @whole = [columns] + data
      @widths = calculate_widths
    end

    def print
      [write_divider, write_header, write_divider, write_lines, write_divider].join("\n")
    end

    private

    def write_divider
      "+-#{@widths.map { |width| '-'*width }.join('-+-') }-+"
    end

    def write_lines
      @data.map do |line|
        write_line(line)
      end.join("\n")
    end

    def write_line(line)
      str = line.each_with_index.map { |data, index| data.to_s.ljust(@widths[index]) }.join(' | ')
      "| #{str} |"
    end

    def write_header
      write_line(@columns)
    end

    def calculate_widths
      @columns.each_index.map do |index|
        @whole.transpose[index].map(&:to_s).map(&:length).max
      end
    end
  end
end
