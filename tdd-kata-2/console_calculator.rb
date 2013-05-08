require_relative 'string_calculator'

DELEGATIONS =  {
  "scalc" => StringCalculator
}

def parse(string)
  command, parameters = string.split(" ")
  parameters.gsub!('\'', "")
  [command, parameters]
end

def delegator(command, param)
  if DELEGATIONS.has_key? command
    DELEGATIONS[command].add(param)
  else
    raise Exception
  end
end

def read(args)
  raise Exception if args.empty?
  command, param = parse(args[0])
  delegator(command, param)
end

def outputter(result)
  puts "The result is #{result}"
end

# Uncomment this if want to run this file
# outputter(read(ARGV))