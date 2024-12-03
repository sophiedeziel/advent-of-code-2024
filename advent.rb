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
  puts "Partie 1: " + instance.part1.to_s
  puts "Partie 2: " + instance.part2.to_s
  system("stty raw -echo")
end

listener = Listen.to('.', only: /\.rb$/, ignore: /advent.rb$/) do |modified, added, removed|
  [modified].flatten.each do |file|
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
    File.write("#{dir_name}/input.txt", "")
    File.write("#{dir_name}/example.txt", "")
    File.write("#{dir_name}/solution.rb", File.open("solution_template.rb", 'r').read.gsub("<<dir>>", dir_name))
  end
end
