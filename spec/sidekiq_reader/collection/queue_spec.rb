# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqReader::Collection::Queue do
  describe '#fetch_all' do
    let(:fake_client) do
      client = instance_double(SidekiqReader::Client)
      allow(client).to receive(:connection)
      client
    end
    let(:formatted_response) do
      [
        ['QueueName', '0', '1,873.23 (1 day ago)', '']
      ]
    end
    let(:queue_collection) do
      queue_collection = described_class.new(fake_client)
      allow(queue_collection).to receive(:formatted_response).and_return formatted_response
      queue_collection
    end
    let(:params) do
      {
        name: 'QueueName',
        size: '0',
        latency: '1,873.23 (1 day ago)',
        actions: ''
      }
    end
    let(:view) { class_spy(SidekiqReader::View::Queue) }

    it 'returns an array of all the queues' do
      expect(queue_collection.fetch_all).to be_an(Array)
    end

    it 'the array returns View::Queue objects' do
      expect(queue_collection.fetch_all.first).to be_an(SidekiqReader::View::Queue)
    end

    it 'sends the correct information to the View::Queue class' do
      allow(queue_collection).to receive(:view).and_return(view)
      queue_collection.fetch_all
      expect(view).to have_received(:new).with(params)
    end
  end
end
