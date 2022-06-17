# frozen_string_literal: true

module SidekiqReader
  module View
    class Enqueued < Base
      attribute :number
      attribute :name
      attribute :arguments

      def self.in(queue)
        @queue = queue
        self
      end

      def self.all
        @collection.in(@queue).fetch_all
      end
    end
  end
end
