
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

    @correctly_ordered, @incorectly_ordered = @updates.partition do |update|
      @rules.all? do |(x,y)|
        next true if update.index(x).nil? || update.index(y).nil?
        update.index(x) < update.index(y)
      end
    end
  end

  def part1
    @correctly_ordered.map { |update| update[update.count/2] }.sum
  end

  def part2
    @incorectly_ordered.map do |update|
      update.each do |page|
        applicable_rules = @rules.select { |x,y| update.include?(x) && update.include?(y) }
          applicable_rules.each do |(x,y)|
            next if update.index(x) < update.index(y)
            update.insert(update.index(x), update.delete_at(update.index(y)))
          end
      end
    end.map { |update| update[update.count/2] }.sum
  end
end
