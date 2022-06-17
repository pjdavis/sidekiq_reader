# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqReader::ResponseMapping::BusyJob do
  describe '.list_parser' do
    let(:html) { File.read('spec/fixtures/busy.html') }
    let(:doc) { Nokogiri::HTML(html) }
    let(:expected_response) do
      [
        ['ip-127-0-0-1:1000:ac88d66ef7', 'tid1', 'jid1', 'queue1', 'QueueWorker', '"arg1"',
         '2022-06-01 00:10:00 +0000'],
        ['ip-127-0-0-1:1000:ac88d66ef7', 'tid2', 'jid2', 'queue2', 'QueueWorker', '"arg1"',
         '2022-06-01 00:10:00 +0000']
      ]
    end

    it 'returns an array of busy jobs' do
      expect(described_class.list_parser.call(doc)).to eq expected_response
    end
  end
end
