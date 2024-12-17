require 'listen'
require 'pry'
require 'io/console'

def reset_screen
  system "clear"

  puts "Advent of Code"
  puts "=============="
  puts "q: Quit, i: Use input, e: Use example, r: Reload, n: Next day"
  puts ""
end

reset_screen

class BaseSolution
  def set_size(size)
    @size = size
  end

  def tick
    @current = @current + 1
    percent = (@current / @size.to_f * 100).round(2)
    print "#{percent}%\r"
  end

  def reset_ticks
    @current = 0
    @size = 0
  end
end

@last_file = nil
@input_mode = "example"

def run(file)
  system("stty -raw echo")
  reset_screen
  @last_file = file
  load(@last_file)
  instance = Solution.new(@input_mode)

  instance.reset_ticks
  result = instance.part1
  puts "Partie 1: " + result.to_s

  instance.reset_ticks
  result = instance.part2
  puts "Partie 2: " + result.to_s

  rescue => e
    puts e.detailed_message
    puts e.backtrace
  ensure
    system("stty raw -echo")
end

@listener = Listen.to('.', only: /\.rb$/, ignore: /advent.rb$/) do |modified, added, removed|
  [modified].flatten.each do |file|
    run(file)
  end
end

@listener.start

loop do
  c = STDIN.getch
  system("stty -raw echo")
  case c
  when 'q'
    break
  when 'r'
    run(@last_file)
  when 'i'
    @input_mode = "input"
    run(@last_file)
  when 'e'
    @input_mode = "example"
    run(@last_file)
  when 'n'
    next_day = Dir.glob('*').select {|f| File.directory? f}.select {|f| f.match?(/jour-\d+/)}.count + 1
    dir_name = "jour-#{next_day.to_s.rjust(2, '0')}"
    Dir.mkdir dir_name

    File.write("#{dir_name}/solution.rb", File.open("solution_template.rb", 'r').read.gsub("<<dir>>", dir_name))
    puts "Created #{dir_name}/solution.rb"

    File.write("#{dir_name}/input.txt", "")
    puts "Created #{dir_name}/input.txt"

    File.write("#{dir_name}/example.txt", "")
    puts "Created #{dir_name}/example.txt"
  end
end
