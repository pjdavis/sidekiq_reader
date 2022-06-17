# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqReader::View::BusyProcess do
  describe '#name' do
    it 'is present' do
      busy_name = described_class.new(name: 'name')
      expect(busy_name.name).to eq 'name'
    end
  end

  describe '#queues' do
    it 'is present' do
      busy_process = described_class.new(queues: 'queue1, queue2')
      expect(busy_process.queues).to eq 'queue1, queue2'
    end
  end

  describe '#started' do
    it 'is present' do
      busy_process = described_class.new(started: '2022-01-01 12:12:42')
      expect(busy_process.started).to eq '2022-01-01 12:12:42'
    end
  end

  describe '#rss' do
    it 'is present' do
      busy_process = described_class.new(rss: '1.5')
      expect(busy_process.rss).to eq '1.5'
    end
  end

  describe '#threads' do
    it 'is present' do
      busy_process = described_class.new(threads: 1)
      expect(busy_process.threads).to eq 1
    end

    it 'is cast to an integer' do
      busy_process = described_class.new(threads: '1')
      expect(busy_process.threads).to eq 1
    end
  end

  describe '#busy' do
    it 'is present' do
      busy_process = described_class.new(busy: 1)
      expect(busy_process.busy).to eq 1
    end

    it 'is cast to an integer' do
      busy_process = described_class.new(busy: '1')
      expect(busy_process.busy).to eq 1
    end
  end

  describe '#actions' do
    it 'is present' do
      busy_process = described_class.new(actions: '')
      expect(busy_process.actions).to eq ''
    end
  end
end
