# frozen_string_literal: true

module SidekiqReader
  module View
    class Count < Base
      attribute :processed, cast: :cast_to_integer
      attribute :failed, cast: :cast_to_integer
      attribute :busy, cast: :cast_to_integer
      attribute :enqueued, cast: :cast_to_integer
      attribute :retries, cast: :cast_to_integer
      attribute :scheduled, cast: :cast_to_integer
      attribute :dead, cast: :cast_to_integer

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
