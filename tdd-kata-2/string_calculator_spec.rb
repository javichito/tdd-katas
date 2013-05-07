require 'rubygems'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/setup'

require_relative 'string_calculator'

describe StringCalculator do
  describe ".add" do
    it "can receive an empty string" do
      StringCalculator.add("").must_equal 0
    end

    it "can receive one number" do
      StringCalculator.add("5").must_equal 5
    end

    it "can receive two numbers" do
      StringCalculator.add("5,7").must_equal 12
    end

    it "can receive n numbers" do
      StringCalculator.add("30,50,10,5,28,5").must_equal 128
    end

    it "can handle comma separator" do
      StringCalculator.add("1,2,3").must_equal 6
    end

    it "can handle new lines separator" do
      StringCalculator.add("1\n2,3").must_equal 6
    end

    it "can handle custom delimiters" do
      StringCalculator.add("//;\n1;2;3").must_equal 6
    end

    it "raises an exception on negative number" do
      exception = lambda { StringCalculator.add("5,-3,1,-2") }.must_raise(Exception)
      exception.message.must_equal "negatives not allowed: -3,-2"
    end

    it "should output the result to the console" do
      StringCalculator.expects(:puts).with(10).returns(nil)
      StringCalculator.add("7,3")
    end
  end
end