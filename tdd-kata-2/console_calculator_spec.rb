require 'rubygems'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/setup'

require_relative 'console_calculator'

describe "Console Calculator" do
  describe "read" do
    it "should raise an exception if it receives an empty array" do
      lambda { read([]) }.must_raise Exception
    end

    it "should call parse with the first element of the array" do
      expects(:parse).with("scalc '1,2,3'")
      stubs(:delegator)
      read(["scalc '1,2,3'", "b", "c"])
    end

    it "should call delegator with the parsed response" do
      expects(:delegator).with("scalc", "1,2,3")
      read(["scalc '1,2,3'"])
    end
  end

  describe "parse" do
    it "should return command and its parameters" do
      parse("scalc '1,2,3'").must_equal ["scalc", "1,2,3"]
    end
  end

  describe "delegator" do
    it "should return the proper class for the command" do
      delegator("scalc", "1,2,3").must_equal 6
    end

    it "should raise an Exception if command doesn't exist" do
      lambda { delegator("rarecommand", "1,2") }.must_raise Exception
    end
  end

  describe "outputter" do
    it "should output the response to the console" do
      expects(:puts).with("The result is 6")
      outputter(6)
    end
  end

  describe "ask_again" do
    before do
      stubs(:exit)
      stubs(:puts)
    end

    it "should asks the user for input" do
      stubs(:gets).returns("\n")
      expects(:puts).with("another input please:")
      ask_again
    end

    describe "with input" do
      before do
       $command = "scalc"
       stubs(:gets).returns("1,2,3\n")
     end

      it "should pass the input to delegator with proper command" do
        expects(:delegator).with($command, "1,2,3")
        ask_again
      end

      it "should call outputter with the new result" do
        expects(:outputter).with(6)
        ask_again
      end
    end

    describe "with no input" do
      it "should exit" do
        stubs(:gets).returns("\n")
        expects(:exit)
        ask_again
      end
    end
  end

  it "should call outputter with the right param" do
    expects(:outputter).with(6)
    outputter read(["scalc '1,2,3'"])
  end
end