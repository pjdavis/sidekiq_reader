# frozen_string_literal: true

module SidekiqReader
  module View
    class Queue < Base
      attribute :name
      attribute :size, cast: :cast_to_integer
      attribute :latency, cast: :cast_to_float

      private

      def cast_to_integer(value)
        return nil if value.nil?

        if value.respond_to?(:split)
          value.split.first.delete(',').to_i
        else
          value.to_i
        end
      end

      def cast_to_float(value)
        return nil if value.nil?

        if value.respond_to?(:split)
          value.split.first.delete(',').to_f
        else
          value.to_f
        end
      end
    end
  end
end
