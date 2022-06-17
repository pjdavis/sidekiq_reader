# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqReader::Collection::Enqueued do
  let(:fake_client) do
    client = instance_double(SidekiqReader::Client)
    allow(client).to receive(:connection)
    client
  end
  let(:enqueued_collection) do
    enqueued_collection = described_class.new(fake_client)
    allow(enqueued_collection).to receive(:formatted_response).and_return formatted_response
    enqueued_collection
  end
  let(:formatted_response) do
    [
      ['10101', 'SomeProcessJob', '"23423-2342-2342-223432"', '']
    ]
  end

  describe '#fetch_all' do
    let(:params) do
      {
        number: '10101',
        name: 'SomeProcessJob',
        arguments: '"23423-2342-2342-223432"',
        actions: ''
      }
    end
    let(:view) { class_spy(SidekiqReader::View::Enqueued) }

    it 'returns an array of all the queues' do
      expect(enqueued_collection.fetch_all).to be_an(Array)
    end

    it 'the array returns View::Enqueued objects' do
      expect(enqueued_collection.fetch_all.first).to be_an(SidekiqReader::View::Enqueued)
    end

    it 'sends the correct information to the View::Enqueued class' do
      allow(enqueued_collection).to receive(:view).and_return(view)
      enqueued_collection.fetch_all
      expect(view).to have_received(:new).with(params)
    end
  end

  describe '#in' do
    it 'sets the queue name' do
      collection = enqueued_collection.in('queue1')
      expect(collection.url).to eq '/queues/queue1'
    end
  end
end
