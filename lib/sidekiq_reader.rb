# frozen_string_literal: true

require 'dotenv/load'
require 'httparty'
require 'nokogiri'
require 'thor'

require_relative 'sidekiq_reader/common/class_attribute'

require_relative 'sidekiq_reader/collection/base'
require_relative 'sidekiq_reader/collection/busy_job'
require_relative 'sidekiq_reader/collection/busy_process'
require_relative 'sidekiq_reader/collection/enqueued'
require_relative 'sidekiq_reader/collection/queue'
require_relative 'sidekiq_reader/collection/retries'

require_relative 'sidekiq_reader/response_mapping/busy_job'
require_relative 'sidekiq_reader/response_mapping/busy_process'
require_relative 'sidekiq_reader/response_mapping/enqueued'
require_relative 'sidekiq_reader/response_mapping/queue'
require_relative 'sidekiq_reader/response_mapping/retries'

require_relative 'sidekiq_reader/view/common/attributes'
require_relative 'sidekiq_reader/view/common/initializer'
require_relative 'sidekiq_reader/view/base'
require_relative 'sidekiq_reader/view/busy_job'
require_relative 'sidekiq_reader/view/busy_process'
require_relative 'sidekiq_reader/view/enqueued'
require_relative 'sidekiq_reader/view/queue'
require_relative 'sidekiq_reader/view/retries'

require_relative 'sidekiq_reader/connection'
require_relative 'sidekiq_reader/client'

module SidekiqReader
end
