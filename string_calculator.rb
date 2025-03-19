require 'pry'
class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?

    numbers.gsub(/\n/, ',').split(',').map(&:to_i).reduce(:+)

    delimiter = ","
    if numbers.start_with?("//")
      parts = numbers.split("\n", 2)

      if parts[0].include?("[")
        delimiters = parts[0].scan(/\[(.*?)\]/).flatten
      else
        delimiters = [parts[0][2]]
      end

      numbers = parts[1]
      delimiters.each { |delim| numbers.gsub!(delim, ",") }
    end

    number_array = numbers.gsub(/\n/, delimiter).split(delimiter).map(&:to_i)

    if delimiters == ["o"]
      number_array.select! { |num| num.odd? }
    end

    number_array.reject! { |num| num > 1000 }
    negative_numbers = number_array.select { |num| num < 0 }
    if negative_numbers.any?
      raise "negative numbers not allowed: #{negative_numbers.join(',')}"
    end

    number_array.reduce(:+) || 0
  end
end
