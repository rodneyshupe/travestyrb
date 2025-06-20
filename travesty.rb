#!/usr/bin/env ruby

require 'optparse'

# Default parameters
options = {
  pattern_length: 9,
  output_length: 2000,
  line_width: 0,     # 0 means no wrapping
  output_file: nil
}

OptionParser.new do |opts|
  opts.banner = "Usage: ruby travesty.rb [options]"

  opts.on("-f", "--file FILE", "Input text file") { |v| options[:file] = v }
  opts.on("-p", "--pattern N", Integer, "Pattern length (n-gram)") { |v| options[:pattern_length] = v }
  opts.on("-l", "--length N", Integer, "Output length") { |v| options[:output_length] = v }
  opts.on("-w", "--wrap N", Integer, "Wrap output at N characters per line") { |v| options[:line_width] = v }
  opts.on("-o", "--output FILE", "Write output to a file") { |v| options[:output_file] = v }
end.parse!

unless options[:file] && File.exist?(options[:file])
  puts "Error: Must provide a valid input file with -f or --file."
  exit 1
end

text = File.read(options[:file])
pattern_length = options[:pattern_length]
output_length = options[:output_length]
line_width = options[:line_width]

# Build the Markov table
table = Hash.new { |h, k| h[k] = [] }

(0..text.length - pattern_length - 1).each do |i|
  pattern = text[i, pattern_length]
  next_char = text[i + pattern_length]
  table[pattern] << next_char
end

# Seed and generate text
seed = text[0, pattern_length]
output = seed.dup

(output_length - pattern_length).times do
  choices = table[seed]
  break if choices.empty?

  next_char = choices.sample
  output << next_char
  seed = seed[1..] + next_char
end

# Apply line wrapping if needed
if line_width > 0
  wrapped_output = output.scan(/.{1,#{line_width}}/).join("\n")
else
  wrapped_output = output
end

# Output to file or stdout
if options[:output_file]
  File.write(options[:output_file], wrapped_output)
  puts "Output written to #{options[:output_file]}"
else
  puts wrapped_output
end
