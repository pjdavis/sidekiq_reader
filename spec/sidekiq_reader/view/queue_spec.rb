# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqReader::View::Queue do
  describe '.collection_class' do
    it 'returns the Queue collection class' do
      expect(described_class.collection_class).to eq SidekiqReader::Collection::Queue
    end
  end

  describe '#name' do
    it 'is present' do
      queue = described_class.new(name: 'TestQueue')
      expect(queue.name).to eq 'TestQueue'
    end
  end

  describe '#size' do
    it 'is present' do
      queue = described_class.new(size: 1)
      expect(queue.size).to eq 1
    end

    it 'is cast to an integer' do
      queue = described_class.new(size: '1')
      expect(queue.size).to eq 1
    end
  end

  describe '#latency' do
    it 'is present' do
      queue = described_class.new(latency: 1.5)
      expect(queue.latency).to eq 1.5
    end

    it 'is cast to a float' do
      queue = described_class.new(latency: '1.5')
      expect(queue.latency).to eq 1.5
    end
  end
end
