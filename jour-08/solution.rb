
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

  # 845 too low
  def part2
    @antinodes = []
    @antenas.each do |antena, points|
      to_check = points.dup
      while to_check.any?
        point = to_check.shift
        to_check.each do |other_point|
          ln, col = point
          ln2, col2 = other_point

          distanceln = (ln2 - ln)
          distancecol = (col2 - col)

          while in_map?(ln, col)
            @antinodes << [ln, col]
            ln -= distanceln
            col -= distancecol
          end

          ln, col = point

          while in_map?(ln2, col2)
            @antinodes << [ln2, col2]
            ln2 += distanceln
            col2 += distancecol
          end
        end
      end
    end
    @antinodes.uniq.count
  end

  private

  def in_map?(x, y)
    x >= 0 && x < @input.count && y >= 0 && y < @input.first.count
  end
end
