require 'thor'

require 'cron/printer'

module Cron
  class CLI < Thor
    ARGUMENTS_MAPPER = {
      minute: 'Minute',
      hour: 'Hour',
      day_of_the_month: 'Day of the month',
      month: 'Month',
      day_of_the_week: 'Day of the week',
      command: 'Command'
    }.freeze

    desc 'parse [minute] [hour] [day_of_the_month] [month] [day_of_the_week] [command]',
         'Parse cron string and print it in Human Readable Format'
    def parse(minute, hour, day_of_the_month, month, day_of_the_week, command)
      results = Cron::Parser.parse(minute, hour, day_of_the_month, month, day_of_the_week, command)

      Cron::Printer.print(results, ARGUMENTS_MAPPER)
    end
  end
end
