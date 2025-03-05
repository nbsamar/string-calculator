class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?

    numbers.gsub(/\n/, ',').split(',').map(&:to_i).reduce(:+)

    delimiter = ","
    if numbers.start_with?("//")
      parts = numbers.split("\n", 2)
      delimiter = parts[0][2]
      numbers = parts[1]
    end

    number_array = numbers.gsub(/\n/, delimiter).split(delimiter).map(&:to_i)
    negative_numbers = number_array.select { |num| num < 0 }
    if negative_numbers.any?
      raise "negative numbers not allowed: #{negative_numbers.join(',')}"
    end

    number_array.reduce(:+)
  end
end
