# frozen_string_literal: true

module SidekiqReader
  module Collection
    class Enqueued < Base
      class_attribute :path, default: '/queues'
      class_attribute :list_cols, default: { 0 => :number,
                                             1 => :name,
                                             2 => :arguments,
                                             3 => :actions }

      def initialize(client)
        super
        @queue = nil
      end

      def in(queue)
        @queue = queue
        self
      end

      def url
        "#{self.class.path}/#{@queue}"
      end
    end
  end
end
