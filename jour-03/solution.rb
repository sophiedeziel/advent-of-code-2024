
class Solution < BaseSolution
  puts "jour-03"
  def initialize(input_mode)
    @input = File.open("jour-03/#{input_mode}.txt", 'r').read
    muls = @input.scan(/mul\((\d+),(\d+)\)/).map { |m| m.map(&:to_i) }
    @part1 = muls.sum { |m| m[0] * m[1] }
    @part2 = nil
  end

  def part1
    @part1
  end

  def part2
    @part2
  end
end
