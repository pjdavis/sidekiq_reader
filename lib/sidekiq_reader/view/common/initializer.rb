# frozen_string_literal: true

module SidekiqReader
  module View
    module Common
      module Initializer
        def initialize(params)
          tap do |_view|
            params.each do |name, value|
              next unless respond_to?("#{name}=")

              public_send("#{name}=", value)
            end
          end
        end
      end
    end
  end
end
