# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqReader::Collection::BusyProcess do
  describe '#fetch_all' do
    let(:fake_client) do
      client = instance_double(SidekiqReader::Client)
      allow(client).to receive(:connection)
      client
    end
    let(:formatted_response) do
      [
        ['process name', 'Queues: queue', '44 Minutes Ago', '2,230 MB', '50', '23', '']
      ]
    end
    let(:busy_process_collection) do
      busy_process_collection = described_class.new(fake_client)
      allow(busy_process_collection).to receive(:formatted_response).and_return formatted_response
      busy_process_collection
    end
    let(:params) do
      {
        name: 'process name',
        queues: 'Queues: queue',
        started: '44 Minutes Ago',
        rss: '2,230 MB',
        threads: '50',
        busy: '23',
        actions: ''
      }
    end
    let(:view) { class_spy(SidekiqReader::View::BusyProcess) }

    it 'returns an array of all the jobs' do
      expect(busy_process_collection.fetch_all).to be_an(Array)
    end

    it 'has View::BusyProcess objects' do
      expect(busy_process_collection.fetch_all.first).to be_a(SidekiqReader::View::BusyProcess)
    end

    it 'sends the correct info to the View::BusyProcess class' do
      allow(busy_process_collection).to receive(:view).and_return(view)
      busy_process_collection.fetch_all
      expect(view).to have_received(:new).with(params)
    end
  end
end
