# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqReader::View::Scheduled do
  describe '#when' do
    it 'is present' do
      scheduled = described_class.new(when: '2022-01-01 00:00:00')
      expect(scheduled.when).to eq '2022-01-01 00:00:00'
    end
  end

  describe '#queue' do
    it 'is present' do
      scheduled = described_class.new(queue: 'queue1')
      expect(scheduled.queue).to eq 'queue1'
    end
  end

  describe '#job' do
    it 'is present' do
      scheduled = described_class.new(job: 'QueueWorker')
      expect(scheduled.job).to eq 'QueueWorker'
    end
  end

  describe '#arguments' do
    it 'is present' do
      scheduled = described_class.new(arguments: '"arg1"')
      expect(scheduled.arguments).to eq '"arg1"'
    end
  end
end
