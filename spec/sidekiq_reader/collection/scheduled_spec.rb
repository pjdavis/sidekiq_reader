# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqReader::Collection::Scheduled do
  describe '#fetch_all' do
    let(:fake_client) do
      client = instance_double(SidekiqReader::Client)
      allow(client).to receive(:connection)
      client
    end
    let(:formatted_response) do
      [
        ['2022-06-01T00:10:00Z', 'queue1', 'QueueWorker', '"arg1"']
      ]
    end
    let(:scheduled_collection) do
      scheduled_collection = described_class.new(fake_client)
      allow(scheduled_collection).to receive(:formatted_response).and_return(formatted_response)
      scheduled_collection
    end
    let(:params) do
      {
        when: '2022-06-01T00:10:00Z',
        queue: 'queue1',
        job: 'QueueWorker',
        arguments: '"arg1"'
      }
    end
    let(:view) { class_spy(SidekiqReader::View::Scheduled) }

    it 'returns an array of all the scheduled jobs' do
      expect(scheduled_collection.fetch_all).to be_an(Array)
    end

    it 'returns View::Scheduled objects' do
      expect(scheduled_collection.fetch_all.first).to be_a(SidekiqReader::View::Scheduled)
    end

    it 'sends the correct information ot the View::Scheduled class' do
      allow(scheduled_collection).to receive(:view).and_return(view)
      scheduled_collection.fetch_all
      expect(view).to have_received(:new).with(params)
    end
  end
end
