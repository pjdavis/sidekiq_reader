# frozen_string_literal: true

module SidekiqReader
  class CLI < Thor
    class_option :headers, type: :boolean, default: true
    class_option :table, type: :boolean

    desc 'queues', 'Show Queues'

    def queues
      cols = %w[name latency size].freeze
      data = client.queue.all.map { |queue| cols.map { |col| queue.send(col.to_sym) } }
      display(cols, data)
    end

    desc 'enqueued QUEUE', 'show all jobs in a queue'

    def enqueued(_queue)
      cols = %w[number name arguments].freeze
      data = client.queue.all.map { |queue| cols.map { |col| queue.send(col.to_sym) } }
      display(cols, data)
    end

    desc 'busy [JOBS, PROCESSES]', 'show all busy jobs or processes'

    def busy(type)
      cols, data = case type
                   when 'jobs'
                     cols = %w[process tid jid queue job arguments started].freeze
                     data = client.busy_job.all.map { |busy_job| cols.map { |col| busy_job.send(col.to_sym) } }
                     [cols, data]
                   when 'processes'
                     cols = %w[name queues started rss threads busy].freeze
                     data = client.busy_process.all.map do |busy_process|
                       cols.map do |col|
                         busy_process.send(col.to_sym)
                       end
                     end
                     [cols, data]
                   end
      display(cols, data)
    end

    desc 'retries', 'shows all retries'

    def retries
      cols = %w[next_retry retry_count queue job arguments error].freeze
      data = client.retries.all.map { |retries| cols.map { |col| retries.send(col.to_sym) } }
      display(cols, data)
    end

    desc 'scheduled', 'shows scheduled jobs'

    def scheduled
      cols = %w[when queue job arguments].freeze
      data = client.scheduled.all.map { |scheduled| cols.map { |col| scheduled.send(col.to_sym) } }
      display(cols, data)
    end

    desc 'count [CATEGORY]', 'shows count for category'

    def count(category = nil)
      cols = %w[processed failed busy enqueued retries scheduled dead]
      counts = client.count.all
      if cols.include?(category)
        puts counts.first.send(category.to_sym)
      else
        display(cols, counts.map { |count| cols.map { |col| count.send(col.to_sym) } })
      end
    end

    private

    def client
      Client.new
    end

    def display(cols, data)
      if options[:table]
        puts SidekiqReader::Table.new(cols, data).print
      else
        puts cols.join(', ') if options[:headers]
        data.each { |line| puts line.join(', ') }
      end
    end

    def print_line(cols, line)
      puts cols.map { |col| line.send(col.to_sym) }.join(', ')
    end

    def map_lines(cols, resp)
      resp.map do |line|
        cols.map { |col| line.send(col.to_sym) }
      end
    end
  end
end
