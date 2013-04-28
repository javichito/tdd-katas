require 'minitest/autorun'
require 'minitest/pride'
require_relative 'string_calculator'

class StringCalculatorTest < MiniTest::Unit::TestCase
  def test_add_with_empty_string
    assert_equal 0, StringCalculator.add("")
  end

  def test_add_with_one_number
    assert_equal 5, StringCalculator.add("5")
  end

  def test_add_with_two_numbers
    assert_equal 12, StringCalculator.add("5,7")
  end

  def test_add_with_n_numbers
    assert_equal 128, StringCalculator.add("30,50,10,5,28,5")
  end
end