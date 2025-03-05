class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?

    return numbers.to_i if numbers.length == 1

    numbers.gsub(/\n/, ',').split(',').map(&:to_i).reduce(:+)
  end
end
