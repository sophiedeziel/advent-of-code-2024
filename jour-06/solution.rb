
class Solution < BaseSolution
  puts "jour-06"
  def initialize(input_mode)
    @map = File.open("jour-06/#{input_mode}.txt", 'r').map { |line| line.chomp }.map do |line|
      line.split('')
    end

    @directions = [[-1,0], [0,1], [1,0], [0,-1]]

    ln = @map.index { |line| line.include?('^') }
    col = @map[ln].index('^')
    @position = [ln, col]
    @direction = 0

    while in_map?(@position) do
      move_guard
    end

    @part1 = nil
    @part2 = nil
  end

  def part1
    @map.map { |l| l.count('X') }.sum
  end

  def part2
    @part2
  end

  def move_guard
    @map[@position[0]][@position[1]] = 'X'
    next_position = calculate_next_position
    while colision?(next_position)
      turn_right
      next_position = calculate_next_position
    end
    @position = next_position
  end

  def calculate_next_position
    ln = @position[0] + @directions[@direction][0]
    col = @position[1] + @directions[@direction][1]
    [ln, col]
  end

  def in_map?(position)
    ln = position[0]
    col = position[1]
    ln >= 0 && ln < @map.size && col >= 0 && col < @map[0].size
  end

  def colision?(position)
    return false if !in_map?(position)
    @map[position[0]][position[1]] == '#'
  end

  def turn_right
    @direction = (@direction + 1) % 4
  end
end
