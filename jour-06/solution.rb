
class Solution < BaseSolution
  puts "jour-06"
  def initialize(input_mode)
    @map = File.open("jour-06/#{input_mode}.txt", 'r').map { |line| line.chomp }.map do |line|
      line.split('')
    end.compact

    @directions = [[-1,0], [0,1], [1,0], [0,-1]]
  end

  def part1
    run(@map.dup)
    @path.values.count - 1
  end

  # lent. Je suis sure qu'il y a des optimisations à faire
  def part2
    to_block =  @path.keys.map &:dup
    to_block.count do |(line_i, col_i)|
      map = @map.map &:dup
      next if map[line_i].nil?
      next if map[line_i][col_i] == '^'
      map[line_i][col_i] = "#"
      run(map)

      @in_loop
    end
  end


  private

  def run(map)
    ln = map.index { |line| line.include?('^') }
    col = map[ln].index('^')
    @position = [ln, col]
    @direction = 0

    @path = {}
    @in_loop = false

    while in_map?(@position, map) && @in_loop == false do
      move_guard(map)
      @path[@position] ||= []
      # puts @path[@position].inspect
      # puts @direction

      if @path[@position].any? { |d| d == @direction }
        @in_loop = true
        # puts "in loop"
      end


      @path[@position].push @direction  if in_map?(@position, map)
    end
  end

  def move_guard(map)
    next_position = calculate_next_position
    while colision?(next_position, map)
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

  def in_map?(position, map)
    ln = position[0]
    col = position[1]
    ln >= 0 &&
      ln < (map.size) &&
      col >= 0 &&
      col < (map[0].size)
  end

  def colision?(position, map)
    return false if !in_map?(position, map)
    map[position[0]][position[1]] == '#'
  end

  def turn_right
    @direction = (@direction + 1) % 4
  end
end
