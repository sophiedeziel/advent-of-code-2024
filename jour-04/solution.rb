
class Solution < BaseSolution
  puts "jour-04"
  def initialize(input_mode)
    @input = File.open("jour-04/#{input_mode}.txt", 'r').map(&:chomp).map(&:each_char).map(&:to_a)

    @visual = Array.new(@input.count).map { Array.new(@input[0].count, ".") }

    @part1 = @input
    @part2 = nil
  end

  def part1
    sum = @input.each_with_index.sum do |line, ln|
      line.each_with_index.sum do |char, col|
        scan_xmas(char, ln, col)
      end
    end

    # @visual.each do |line|
    #   puts line.join
    # end

    sum
  end

  def part2
    @part2
  end

  private

  def scan_xmas(char, ln, col)
    return 0 if char != "X"
    vectors = [
      [-1,-1],
      [-1, 0],
      [-1, 1],
      [ 0,-1],
      [ 0, 1],
      [ 1,-1],
      [ 1, 0],
      [ 1, 1]
    ]
    vectors.count do |vln, vcol|
      next if ln + vln <= -1 || ln + vln >= @input.count
      next if col + vcol < 0 || col + vcol >= @input[ln].count
      next if @input.dig(ln + vln,     col + vcol) != "M"
      next if ln + vln * 2 < 0 || ln + vln * 2 >= @input.count
      next if col + vcol * 2 < 0 || col + vcol * 2 >= @input[ln].count
      next if @input.dig(ln + vln * 2, col + vcol * 2) != "A"
      next if ln + vln * 3 < 0 || ln + vln * 3 >= @input.count
      next if col + vcol * 3 < 0 || col + vcol * 3 >= @input[ln].count
      next if @input.dig(ln + vln * 3, col + vcol * 3) != "S"


      @visual[ln][col] = "X"
      @visual[ln + vln][col + vcol] = "M"
      @visual[ln + vln * 2][col + vcol * 2] = "A"
      @visual[ln + vln * 3][col + vcol * 3] = "S"
      true
    end
  end
end
