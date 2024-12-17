
class Solution < BaseSolution
  puts "jour-08"
  def initialize(input_mode)
    @antenas = {}
    @input = File.open("jour-08/#{input_mode}.txt", 'r').each_with_index.map do |line, ln|
      points = line.chomp.split('')
      points.each_with_index.select { |p, col| p != '.'}.each do |p, col|
        @antenas[p] ||= []
        @antenas[p] << [ln, col]
      end
      points
    end

  end

  def part1
    @antinodes = []
    @antenas.each do |antena, points|
      to_check = points.dup
      while to_check.any?
        point = to_check.shift
        to_check.each do |other_point|
          x, y = point
          x2, y2 = other_point
          antinode1 = [x - (x2 - x), y - (y2 - y)]
          antinode2 = [x2 + (x2 - x), y2 + (y2 - y)]
          @antinodes << antinode1 if in_map?(*antinode1)
          @antinodes << antinode2 if in_map?(*antinode2)
        end
      end
    end
    @antinodes.uniq.count
  end

  def part2
    @part2
  end

  private

  def in_map?(x, y)
    x >= 0 && x < @input.count && y >= 0 && y < @input.first.count
  end
end
