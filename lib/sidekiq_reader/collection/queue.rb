# frozen_string_literal: true

module SidekiqReader
  module Collection
    class Queue < Base
      class_attribute :path, default: '/queues'
      class_attribute :list_cols, default: { 0 => :name,
                                             1 => :size,
                                             2 => :latency,
                                             3 => :actions }.freeze
    end
  end
end
