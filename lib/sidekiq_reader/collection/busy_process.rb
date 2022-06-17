# frozen_string_literal: true

module SidekiqReader
  module Collection
    class BusyProcess < Base
      class_attribute :path, default: '/busy'
      class_attribute :list_cols, default: { 0 => :name,
                                             1 => :queues,
                                             2 => :started,
                                             3 => :rss,
                                             4 => :threads,
                                             5 => :busy,
                                             6 => :actions }.freeze
    end
  end
end
