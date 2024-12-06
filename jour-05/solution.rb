
class Solution < BaseSolution
  puts "jour-05"
  def initialize(input_mode)
    @input = File.open("jour-05/#{input_mode}.txt", 'r')
    @rules = []
    @updates = []

    while ((line = @input.gets) && line != "\n")
      @rules << line.chomp.split("|").map(&:to_i)
    end

    while (line = @input.gets)
      @updates << line.chomp.split(",").map(&:to_i)
    end
  end

  def part1
    @updates.select do |update|
      @rules.all? do |(x,y)|
        next true if update.index(x).nil? || update.index(y).nil?
        update.index(x) < update.index(y)
      end
    end.map { |update| update[update.count/2] }.sum

  end

  def part2
    @part2
  end
end
