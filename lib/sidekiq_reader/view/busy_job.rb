# frozen_string_literal: true

module SidekiqReader
  module View
    class BusyJob < Base
      attribute :process
      attribute :tid
      attribute :jid
      attribute :queue
      attribute :job
      attribute :arguments
      attribute :started
    end
  end
end
