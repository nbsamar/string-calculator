require_relative '../string_calculator'

RSpec.describe StringCalculator do
  describe '.add' do
    it 'returns 0 for an empty string' do
      expect(StringCalculator.add('')).to eq(0)
    end

    it 'returns the number for a single number' do
      expect(StringCalculator.add('1')).to eq(1)
    end

    it 'returns the sum of two numbers' do
      expect(StringCalculator.add('1,2')).to eq(3)
    end

    it 'returns the sum of multiple numbers' do
      expect(StringCalculator.add('1,2,3,4,5')).to eq(15)
    end

    it 'handles new lines between numbers' do
      expect(StringCalculator.add("1\n2,3")).to eq(6)
    end

    it 'supports different delimiters' do
      expect(StringCalculator.add("//;\n1;2")).to eq(3)
    end

    it 'should raise an exception for negative numbers' do
      expect { StringCalculator.add("1,-2") }.to raise_error("negative numbers not allowed: -2")
    end

    it 'should raise an exception for multiple negative numbers' do
      expect { StringCalculator.add("1,-2,-3") }.to raise_error("negative numbers not allowed: -2,-3")
    end

    it 'ignores numbers greater than 1000' do
      expect(StringCalculator.add("2,1001")).to eq(2)
      expect(StringCalculator.add("1000,999")).to eq(1999) # <= 1000 is a acceptable case according to Kata.
      expect(StringCalculator.add("1001,1002,5")).to eq(5)
    end

    it 'supports delimiters of any length' do
      expect(StringCalculator.add("//[***]\n1***2***3")).to eq(6)
      expect(StringCalculator.add("//[###]\n4###5###6")).to eq(15)
    end

    it 'supports multiple delimiters' do
      expect(StringCalculator.add("//[*][%]\n1*2%3")).to eq(6)
      expect(StringCalculator.add("//[#][@]\n2#3@4")).to eq(9)
      expect(StringCalculator.add("//[*][%]\n1*2%3%4*5")).to eq(15)
    end

    it 'supports multiple delimiters with length longer than one char' do
      expect(StringCalculator.add("//[***][%%%]\n1***2%%%3")).to eq(6)
      expect(StringCalculator.add("//[###][@@@@]\n4###5@@@@6")).to eq(15)
      expect(StringCalculator.add("//[!!][???]\n10!!20???30")).to eq(60)
    end

    it 'adds only odd numbers if delimiter is o' do
      expect(StringCalculator.add("//[o]\n1o2o3")).to eq(4)
      expect(StringCalculator.add("//[o]\n2o2o4")).to eq(0)
      expect(StringCalculator.add("//[o]\n2o2o9o11")).to eq(20)
    end
  end
end
