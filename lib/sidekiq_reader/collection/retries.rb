# frozen_string_literal: true

module SidekiqReader
  module Collection
    class Retries < Base
      class_attribute :path, default: '/retries'
      class_attribute :list_cols, default: { 0 => :next_retry,
                                             1 => :retry_count,
                                             2 => :queue,
                                             3 => :job,
                                             4 => :arguments,
                                             5 => :error }.freeze
    end
  end
end
