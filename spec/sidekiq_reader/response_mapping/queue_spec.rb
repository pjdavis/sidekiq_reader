# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqReader::ResponseMapping::Queue do
  describe '.list_parser' do
    let(:html) { File.read('spec/fixtures/queues.html') }
    let(:doc) { Nokogiri::HTML(html) }

    it 'returns an array of queue info' do
      expected_response = [
        ['queue1', '10', '0', ''],
        ['queue2', '5', '1,000 (1 day ago)', '']
      ]
      expect(described_class.list_parser.call(doc)).to eq expected_response
    end
  end
end
