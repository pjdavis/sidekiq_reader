# frozen_string_literal: true

module SidekiqReader
  module Collection
    class Count < Base
      class_attribute :path, default: '/'
      class_attribute :list_cols, default: { 0 => :processed,
                                             1 => :failed,
                                             2 => :busy,
                                             3 => :enqueued,
                                             4 => :retries,
                                             5 => :scheduled,
                                             6 => :dead }.freeze
    end
  end
end
