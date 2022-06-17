# frozen_string_literal: true

module SidekiqReader
  module View
    module Common
      module Attributes
        def self.included(base)
          base.extend ClassMethods
        end

        module ClassMethods
          def inherited(sub_class)
            super
            sub_class.class_attribute :attributes, default: []
          end

          def attribute(name, options = {})
            attributes << name
            attr_reader name

            if options[:cast]
              casted_writer(name, options[:cast])
            else
              attr_writer name
            end
          end

          private

          def casted_writer(name, caster)
            if caster.is_a?(Symbol)
              define_method("#{name}=") do |value|
                casted_value = send(caster, value)
                instance_variable_set("@#{name}", casted_value)
              end
            else
              define_method("#{name}=") do |value|
                instance_variable_set("@#{name}", caster.call(value))
              end
            end
          end
        end
      end
    end
  end
end
