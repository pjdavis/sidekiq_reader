# frozen_string_literal: true

module SidekiqReader
  class Connection

    def initialize(config)
      @config = config
    end
    def get_page(url, parser = nil)
      resp = party.get(build_url(url), basic_auth: auth)
      if parser.nil?
        process_body(resp)
      else
        parser.call(process_body(resp))
      end
    end

    private

    def build_url(url)
      "#{@config.sidekiq_url}#{url}"
    end

    def auth
      {
        username: @config.basic_username,
        password: @config.basic_password
      }
    end

    def party
      HTTParty
    end

    def process_body(response)
      Nokogiri::HTML(response.body) if response.body
    end
  end
end
