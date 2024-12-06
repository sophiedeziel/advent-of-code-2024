
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
      applicable_rules(update).all? { |rule| valid?(update, rule) }
    end
  end

  def part1
    middle_number_sum(@correctly_ordered)
  end

  def part2
    middle_number_sum(reorder(@incorectly_ordered))
  end

  private

  def reorder(updates)
    updates.each do |update|
      while !applicable_rules(update).all? { |rule| valid?(update, rule) }
        applicable_rules(update).each do |rule|
          next if valid?(update, rule)
          x, y = rule
          update.insert(update.index(x), update.delete_at(update.index(y)))
        end
      end
    end
  end

  def middle_number_sum(list)
    list.map { |update| update[update.count/2] }.sum
  end

  def applicable_rules(update)
    @rules.select { |x,y| update.include?(x) && update.include?(y) }
  end

  def valid?(update, rule)
    x, y = rule
    update.index(x) < update.index(y)
  end
end
