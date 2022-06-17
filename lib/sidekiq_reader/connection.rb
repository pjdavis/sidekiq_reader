# frozen_string_literal: true

module SidekiqReader
  class Connection
    DEFAULT_URL = ENV.fetch('SIDEKIQ_URL', nil)

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
      "#{DEFAULT_URL}#{url}"
    end

    def auth
      {
        username: ENV.fetch('BASIC_USERNAME', nil),
        password: ENV.fetch('BASIC_PASSWORD', nil)
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
