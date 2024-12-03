require 'listen'
require 'pry'
require 'io/console'

system "clear"

class BaseSolution
end

@last_file = nil
@input_mode = "input"

def run(file)
  system("stty -raw echo")
  system "clear"
  puts "File: #{file}"
  puts @input_mode
  @last_file = file
  load(@last_file)
  instance = Solution.new(@input_mode)
  puts "Partie 1: " + instance.part1
  puts "Partie 2: " + instance.part2
  system("stty raw -echo")
end

listener = Listen.to('.', only: /\.rb$/, ignore: /advent.rb$/) do |modified, added, removed|
  [modified, added].flatten.each do |file|
    begin
      run(file)
    rescue => e
      puts e
    end
  end
end

listener.start

loop do
  c = STDIN.getch
  break if c == 'q'
  run(@last_file) if c == 'r'
  if c == 'i'
    @input_mode = "input"
    run(@last_file)
  end
  if c == 'e'
    @input_mode = "example"
    run(@last_file)
  end
end
