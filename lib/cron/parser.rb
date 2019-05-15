module Cron
  class Parser
    MINUTES = 59
    HOURS = 23
    DAYS_OF_THE_MONTH = 31
    MONTHS = 12
    DAYS_OF_THE_WEEK = 7
    YEARLY = 2050

    RANGE_MAPPER = {
      minute: (0..MINUTES),
      hour: (0..HOURS),
      day_of_the_month: (1..DAYS_OF_THE_MONTH),
      month: (1..MONTHS),
      day_of_the_week: (1..DAYS_OF_THE_WEEK),
      yearly: (2000..YEARLY)
    }.freeze

    class << self
      def parse(minute, hour, day_of_the_month, month, day_of_the_week, yearly, command)
        {
          minute: handle(minute, :minute),
          hour: handle(hour, :hour),
          day_of_the_month: handle(day_of_the_month, :day_of_the_month),
          month: handle(month, :month),
          day_of_the_week: handle(day_of_the_week, :day_of_the_week),
          yearly: handle(yearly, :yearly),
          command: command
        }
      end

      def handle(string, type)
        case string
        when '*'
          RANGE_MAPPER[type].to_a
        when %r{^*/\d*$}
          RANGE_MAPPER[type].step(string.delete('*/').to_i).to_a
        when /^(\d*)-(\d*)$/
          ($1.to_i..$2.to_i).to_a
        when /^\d*(,\d)*/
          string.split(',').map(&:to_i)
        end
      end
    end
  end
end
