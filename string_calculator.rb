class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?

    return numbers.to_i if numbers.length == 1

    numbers.gsub(/\n/, ',').split(',').map(&:to_i).reduce(:+)

    delimiter = ","
    if numbers.start_with?("//")
      parts = numbers.split("\n", 2)
      delimiter = parts[0][2]
      numbers = parts[1]
    end

    numbers.gsub(/\n/, delimiter).split(delimiter).map(&:to_i).reduce(:+)
  end
end
