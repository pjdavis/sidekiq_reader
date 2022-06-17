# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqReader::ResponseMapping::Retries do
  describe '.list_parser' do
    let(:html) { File.read('spec/fixtures/retries.html') }
    let(:doc) { Nokogiri::HTML(html) }

    it 'returns an array of the retry info' do
      expected_response = [
        ['2022-06-10T10:00:00Z', '1', 'queue1', 'QueueWorker', '"arg1"', 'RuntimeError: Invalid input.'],
        ['2022-06-10T10:00:00Z', '1', 'queue2', 'QueueWorker', '"arg2"', 'RuntimeError: Rate limit exceeded']
      ]
      expect(described_class.list_parser.call(doc)).to eq expected_response
    end
  end
end
