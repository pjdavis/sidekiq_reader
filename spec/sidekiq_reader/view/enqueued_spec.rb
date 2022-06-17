# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqReader::View::Enqueued do
  describe '.in' do
    let(:fake_client) do
      instance_double(SidekiqReader::Client)
    end
    let(:enqueued_instance) do
      instance_spy(SidekiqReader::Collection::Enqueued)
    end
    let(:enqueued_collection_class) do
      collection_class = class_double(SidekiqReader::Collection::Enqueued)
      allow(collection_class).to receive(:new).with(fake_client).and_return(enqueued_instance)
      collection_class
    end

    it 'sets the queue name' do
      allow(described_class).to receive(:collection_class).and_return(enqueued_collection_class)
      described_class.with_client(fake_client).in('queue1').all
      expect(enqueued_instance).to have_received(:in).with('queue1')
    end
  end

  describe '#number' do
    it 'is present' do
      enqueued = described_class.new(number: '1')
      expect(enqueued.number).to eq '1'
    end
  end

  describe '#name' do
    it 'is present' do
      enqueued = described_class.new(name: 'TestJob')
      expect(enqueued.name).to eq 'TestJob'
    end
  end

  describe '#arguments' do
    it 'is present' do
      enqueued = described_class.new(arguments: 'Some, Args')
      expect(enqueued.arguments).to eq 'Some, Args'
    end
  end
end
