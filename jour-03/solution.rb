
class Solution < BaseSolution
  puts "jour-03"
  def initialize(input_mode)
    @input = File.open("jour-03/#{input_mode}.txt", 'r').read
    instructions = @input.scan(/(mul\(\d+,\d+\))|(do\(\))|(don't\(\))/).flat_map do |list|
      list.compact
    end
    @part1 = sum_commands(instructions)

    enabled = true
    filtered = []
    instructions.each do |instruction|
      next if instruction.include?('mul(') && !enabled
      next enabled = false if instruction.include?("don't()")
      next enabled = true  if instruction.include?("do()")
      filtered << instruction
    end

    @part2 = sum_commands(filtered)
  end

  def part1
    @part1
  end

  def part2
    @part2
  end

  private

  def sum_commands(instructions)
    instructions.map { |instruction| mul(instruction) if instruction.include?('mul(') }.compact.sum
  end

  def mul(string)
    first, last = string.scan(/\d+/).map(&:to_i)
    first * last
  end
end
