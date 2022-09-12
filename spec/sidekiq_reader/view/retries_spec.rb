# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqReader::View::Retries do
  describe '.collection_class' do
    it 'returns the Retries collection class' do
      expect(described_class.collection_class).to eq SidekiqReader::Collection::Retries
    end
  end

  describe '#next_retry' do
    it 'is present' do
      retries = described_class.new(next_retry: '2022-01-01 00:00:00')
      expect(retries.next_retry).to eq '2022-01-01 00:00:00'
    end
  end

  describe '#retry_count' do
    it 'is present' do
      retries = described_class.new(retry_count: 1)
      expect(retries.retry_count).to eq 1
    end

    it 'is cast to an integer' do
      retries = described_class.new(retry_count: '1')
      expect(retries.retry_count).to eq 1
    end
  end

  describe '#queue' do
    it 'is present' do
      retries = described_class.new(queue: 'queue1')
      expect(retries.queue).to eq 'queue1'
    end
  end

  describe '#job' do
    it 'is present' do
      retries = described_class.new(job: 'job1')
      expect(retries.job).to eq 'job1'
    end
  end

  describe '#arguments' do
    it 'is present' do
      retries = described_class.new(arguments: 'arguments1')
      expect(retries.arguments).to eq 'arguments1'
    end
  end

  describe '#error' do
    it 'is present' do
      retries = described_class.new(error: 'error1')
      expect(retries.error).to eq 'error1'
    end
  end
end
