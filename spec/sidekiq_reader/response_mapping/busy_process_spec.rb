# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqReader::ResponseMapping::BusyProcess do
  describe '.list_parser' do
    let(:html) { File.read('spec/fixtures/busy.html') }
    let(:doc) { Nokogiri::HTML(html) }
    let(:expected_response) do
      [
        [['ip-172-32-0-102:12995', 'kinderlime'], 'queue1, queue2', '2022-06-01 00:10:00 +0000', '5,500 MB', '50', '0',
         '']
      ]
    end

    it 'returns an array of busy processes' do
      expect(described_class.list_parser.call(doc)).to eq expected_response
    end
  end
end
