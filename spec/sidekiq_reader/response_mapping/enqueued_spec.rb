# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqReader::ResponseMapping::Enqueued do
  describe '.list_parser' do
    let(:html) { File.read('spec/fixtures/enqueued.html') }
    let(:doc) { Nokogiri::HTML(html) }
    let(:expected_response) do
      [
        ['6', 'QueueWorker', '', ''],
        ['5', 'QueueWorker', '', ''],
        ['4', 'QueueWorker', '', ''],
        ['3', 'QueueWorker', '', ''],
        ['2', 'QueueWorker', '', ''],
        ['1', 'QueueWorker', '', '']
      ]
    end

    it 'returns an array of queue info' do
      expect(described_class.list_parser.call(doc)).to eq expected_response
    end
  end
end
