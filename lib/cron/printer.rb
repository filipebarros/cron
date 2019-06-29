# frozen_string_literal: true

module Cron
  class Printer
    class << self
      def print(results, mapper)
        column_width = mapper.keys.max_by(&:length).length
        results.each do |key, value|
          next if value.nil?

          column_name = mapper[key]
          result_string = value.is_a?(String) ? value : value.join(' ')

          alignment_spacing = column_width - column_name.length
          puts "#{column_name}#{' ' * alignment_spacing} #{result_string}"
        end
      end
    end
  end
end
