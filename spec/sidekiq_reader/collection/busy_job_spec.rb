# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqReader::Collection::BusyJob do
  describe '#fetch_all' do
    let(:fake_client) do
      client = instance_double(SidekiqReader::Client)
      allow(client).to receive(:connection)
      client
    end
    let(:formatted_response) do
      [
        ['process name', '2', 'jhkasdf8sdfa9', 'queue_name', 'JobName', 'Args, Here', '44 Minutes Ago']
      ]
    end
    let(:busy_job_collection) do
      busy_job_collection = described_class.new(fake_client)
      allow(busy_job_collection).to receive(:formatted_response).and_return formatted_response
      busy_job_collection
    end
    let(:params) do
      {
        process: 'process name',
        tid: '2',
        jid: 'jhkasdf8sdfa9',
        queue: 'queue_name',
        job: 'JobName',
        arguments: 'Args, Here',
        started: '44 Minutes Ago'
      }
    end
    let(:view) { class_spy(SidekiqReader::View::BusyJob) }

    it 'returns an array of all the jobs' do
      expect(busy_job_collection.fetch_all).to be_an(Array)
    end

    it 'has View::BusyJob objects' do
      expect(busy_job_collection.fetch_all.first).to be_a(SidekiqReader::View::BusyJob)
    end

    it 'sends the correct info to the View::BusyJob class' do
      allow(busy_job_collection).to receive(:view).and_return(view)
      busy_job_collection.fetch_all
      expect(view).to have_received(:new).with(params)
    end
  end
end
