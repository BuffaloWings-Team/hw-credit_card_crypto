# frozen_string_literal: true

# Validates credit card number using Luhn Algorithm
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def calculate_sum(num_len, nums_a, weight, total)
    (0..(num_len - 1)).each do |i|
      result = (nums_a[num_len - i - 1].to_i * weight[i].to_i)
      product = result >= 10 ? (result % 10 + (result / 10).floor) : result
      total += product
    end
    total
  end

  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    num_len = nums_a.length
    weight = 12_121_212_121_212_121_212.to_s.split('')
    total = calculate_sum(num_len, nums_a, weight, 0)
    (total % 10).zero? ? true : false
  end
end
