# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqReader::ResponseMapping::Scheduled do
  describe '.list_parser' do
    let(:html) { File.read('spec/fixtures/scheduled.html') }
    let(:doc) { Nokogiri::HTML(html) }
    let(:expected_response) do
      [
        ['2022-06-01T00:10:00Z', 'queue1', 'QueueWorker', '"arg1"'],
        ['2022-06-01T00:10:00Z', 'queue2', 'QueueWorker', '"arg2"']
      ]
    end

    it 'returns an array of the scheduled info' do
      expect(described_class.list_parser.call(doc)).to eq expected_response
    end
  end
end
