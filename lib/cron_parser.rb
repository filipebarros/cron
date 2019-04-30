require 'thor'

require "cron_parser/version"

module CronParser
  class Error < StandardError; end

  class CLI < Thor
    def test
      puts 'test'
    end
  end
end
