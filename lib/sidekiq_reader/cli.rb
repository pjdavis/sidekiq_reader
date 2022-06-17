# frozen_string_literal: true

module SidekiqReader
  class CLI < Thor
    desc 'queues', 'Show Queues'
    def queues
      client.queue.all.each do |queue|
        puts [queue.name, queue.latency, queue.size].join(', ')
      end
    end
    map %w[--queues -q] => :queues

    desc 'enqueued QUEUE', 'show all jobs in a queue'
    def enqueued(queue)
      client.enqueued.in(queue).all.each do |job|
        puts [job.number, job.name, job.arguments].join(', ')
      end
    end
    map %w[--enqueued -e] => :enqueued

    desc 'busy [JOBS, PROCESSES]', 'show all busy jobs or processes'
    def busy(type)
      case type
      when 'jobs'
        client.busy_job.all.each do |job|
          puts [job.process, job.tid, job.jid, job.queue, job.job, job.arguments, job.started].join(', ')
        end
      when 'processes'
        client.busy_process.all.each do |proc|
          puts [proc.name, proc.queues, proc.started, proc.rss, proc.threads, proc.busy].join(', ')
        end
      end
    end
    map %w[--busy -b] => :busy

    desc 'retries', 'shows all retries'
    def retries
      client.retries.all.each do |ret|
        puts [ret.next_retry, ret.retry_count, ret.queue, ret.job, ret.arguments, ret.error].join(', ')
      end
    end
    map %w[--retry -r] => :retry

    private

    def client
      Client.new
    end
  end
end
