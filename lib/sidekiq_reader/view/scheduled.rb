# frozen_string_literal: true

module SidekiqReader
  module View
    class Scheduled < Base
      attribute :when
      attribute :queue
      attribute :job
      attribute :arguments
    end
  end
end
