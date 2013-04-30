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

  def test_add_handle_comma_separator
    assert_equal 6, StringCalculator.add("1,2,3")
  end

  def test_add_handle_new_lines_separator
    assert_equal 6, StringCalculator.add("1\n2,3")
  end

  def test_add_supports_custom_delimiters
    assert_equal 6, StringCalculator.add("//;\n1;2;3")
  end

  def test_add_raises_an_exception_on_negative_number
    exception = assert_raises(Exception) { StringCalculator.add("5,-3,1,-2") }
    assert_equal "negatives not allowed: -3,-2", exception.message
  end
end