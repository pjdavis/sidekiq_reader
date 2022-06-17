# frozen_string_literal: true

module SidekiqReader
  module Collection
    class Base
      include Common::ClassAttribute

      def initialize(client)
        @connection = client.connection
        @records = []
      end

      def fetch_all
        formatted_response.each do |instance|
          params = self.class.list_cols.to_h { |pos, name| [name, instance[pos]] }
          @records << view.new(params)
        end
        @records
      end

      def formatted_response
        mapper.list_parser.call(response)
      end

      def response
        @connection.get_page(url)
      end

      def each(&block)
        @records.each(&block)
      end

      def url
        self.class.path.to_s
      end

      def mapper
        klass = self.class.name.split('::').last
        Object.const_get("SidekiqReader::ResponseMapping::#{klass}")
      end

      def view
        klass = self.class.name.split('::').last
        Object.const_get("SidekiqReader::View::#{klass}")
      end
    end
  end
end
