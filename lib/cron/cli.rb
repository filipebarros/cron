# frozen_string_literal: true

module Cron
  class CLI
    ARGUMENTS_MAPPER = {
      minute: 'Minute',
      hour: 'Hour',
      day_of_the_month: 'Day of the month',
      month: 'Month',
      day_of_the_week: 'Day of the week',
      yearly: 'Yearly',
      command: 'Command'
    }.freeze

    def self.parse(minute, hour, day_of_the_month, month, day_of_the_week, yearly, command)
      results = Cron::Parser.parse(minute, hour, day_of_the_month, month, day_of_the_week, yearly, command)

      Cron::Printer.print(results, ARGUMENTS_MAPPER)
    end
  end
end
