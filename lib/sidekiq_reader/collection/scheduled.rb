# frozen_string_literal: true

module SidekiqReader
  module Collection
    class Scheduled < Base
      class_attribute :path, default: '/scheduled'
      class_attribute :list_cols, default: { 0 => :when,
                                             1 => :queue,
                                             2 => :job,
                                             3 => :arguments }
    end
  end
end
