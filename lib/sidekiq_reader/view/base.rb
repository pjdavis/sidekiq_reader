# frozen_string_literal: true

module SidekiqReader
  module View
    class Base
      include SidekiqReader::Common::ClassAttribute

      def self.inherited(subclass)
        super
        subclass.class_attribute :attributes, default: []
        subclass.include Common::Attributes
        subclass.include Common::Initializer
      end

      def self.all
        @collection.fetch_all
      end

      def self.with_client(client)
        @collection = collection_class.new(client)
        self
      end

      def self.collection_class
        klass = to_s.split('::').last
        Object.const_get("SidekiqReader::Collection::#{klass}")
      end
    end
  end
end
