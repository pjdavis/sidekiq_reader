# frozen_string_literal: true

module SidekiqReader
  module Collection
    class BusyJob < Base
      class_attribute :path, default: '/busy'
      class_attribute :list_cols, default: { 0 => :process,
                                             1 => :tid,
                                             2 => :jid,
                                             3 => :queue,
                                             4 => :job,
                                             5 => :arguments,
                                             6 => :started }.freeze
    end
  end
end
