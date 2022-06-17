# frozen_string_literal: true

module SidekiqReader
  module Common
    module ClassAttribute
      def self.included(klass)
        klass.extend(ClassMethods)
      end

      module ClassMethods
        def class_attribute(name, options = {})
          define_singleton_method(name) { options[:default] }
          define_singleton_method("#{name}=") do |value|
            singleton_class.class_eval do
              define_method(name) { value }
            end
          end
          public_send("#{name}=", options[:default]) if options[:default]
        end
      end
    end
  end
end
