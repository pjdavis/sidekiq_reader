# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqReader::View::BusyJob do
  describe '.collection_class' do
    it 'returns the BusyJob collection class' do
      expect(described_class.collection_class).to eq SidekiqReader::Collection::BusyJob
    end
  end

  describe '#process' do
    it 'is present' do
      busy_job = described_class.new(process: '1')
      expect(busy_job.process).to eq '1'
    end
  end

  describe '#tid' do
    it 'is present' do
      busy_job = described_class.new(tid: '23423423')
      expect(busy_job.tid).to eq '23423423'
    end
  end

  describe '#jid' do
    it 'is present' do
      busy_job = described_class.new(jid: '23423423')
      expect(busy_job.jid).to eq '23423423'
    end
  end

  describe '#queue' do
    it 'is present' do
      busy_job = described_class.new(queue: 'queue name')
      expect(busy_job.queue).to eq 'queue name'
    end
  end

  describe '#job' do
    it 'is present' do
      busy_job = described_class.new(job: 'job name')
      expect(busy_job.job).to eq 'job name'
    end
  end

  describe '#arguments' do
    it 'is present' do
      busy_job = described_class.new(arguments: 'argument, name')
      expect(busy_job.arguments).to eq 'argument, name'
    end
  end

  describe '#started' do
    it 'is present' do
      busy_job = described_class.new(started: '2022-01-01 12:12:42')
      expect(busy_job.started).to eq '2022-01-01 12:12:42'
    end
  end
end
