# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqReader::Collection::Retries do
  describe '#fetch_all' do
    let(:fake_client) do
      client = instance_double(SidekiqReader::Client)
      allow(client).to receive(:connection)
      client
    end
    let(:formatted_response) do
      [
        ['2022-06-10T10:00:00Z', '1', 'queue1', 'QueueWorker', '"arg1"', 'RuntimeError: Invalid input.']
      ]
    end
    let(:retries_collection) do
      retries_collection = described_class.new(fake_client)
      allow(retries_collection).to receive(:formatted_response).and_return formatted_response
      retries_collection
    end
    let(:params) do
      {
        next_retry: '2022-06-10T10:00:00Z',
        retry_count: '1',
        queue: 'queue1',
        job: 'QueueWorker',
        arguments: '"arg1"',
        error: 'RuntimeError: Invalid input.'
      }
    end
    let(:view) { class_spy(SidekiqReader::View::Retries) }

    it 'returns an array of all the queues' do
      expect(retries_collection.fetch_all).to be_an(Array)
    end

    it 'the array returns View::Queue objects' do
      expect(retries_collection.fetch_all.first).to be_an(SidekiqReader::View::Retries)
    end

    it 'sends the correct information to the View::Queue class' do
      allow(retries_collection).to receive(:view).and_return(view)
      retries_collection.fetch_all
      expect(view).to have_received(:new).with(params)
    end
  end
end
