# frozen_string_literal: true

module SidekiqReader
  class Client
    attr_reader :connection

    def initialize(_option = {})
      @connection = Connection.new
      set_views
    end

    private

    def set_views
      views.each_key do |view|
        self.class.define_method(view.to_s) do
          views[view]
        end
      end
    end

    def views
      {
        busy_job: View::BusyJob.with_client(self),
        busy_process: View::BusyProcess.with_client(self),
        enqueued: View::Enqueued.with_client(self),
        queue: View::Queue.with_client(self),
        retries: View::Retries.with_client(self)
      }
    end
  end
end
