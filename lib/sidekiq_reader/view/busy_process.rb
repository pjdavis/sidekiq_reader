# frozen_string_literal: true

module SidekiqReader
  module View
    class BusyProcess < Base
      attribute :name
      attribute :queues
      attribute :started
      attribute :rss
      attribute :threads, cast: ->(value) { value.to_i }
      attribute :busy, cast: ->(value) { value.to_i }
      attribute :actions
    end
  end
end
