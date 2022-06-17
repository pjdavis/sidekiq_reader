# frozen_string_literal: true

module SidekiqReader
  module View
    class Retries < Base
      attribute :next_retry
      attribute :retry_count, cast: :cast_to_integer
      attribute :queue
      attribute :job
      attribute :arguments
      attribute :error

      private

      def cast_to_integer(value)
        return nil if value.nil?

        if value.respond_to?(:split)
          value.split.first.delete(',').to_i
        else
          value.to_i
        end
      end
    end
  end
end
