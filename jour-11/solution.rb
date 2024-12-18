
class Solution < BaseSolution
  puts "jour-11"
  def initialize(input_mode)
    @stones = File.open("jour-11/#{input_mode}.txt", 'r').first.chomp.split().map(&:to_i)
  end

  def part1
    25.times do
      blink
    end


    @stones.count
  end

  def part2

  end

  private

  def blink
    @stones = @stones.flat_map do |stone|
      next 1 if stone == 0
      digits = stone.to_s.split('')
      # puts digits.inspect
      # puts digits.count % 2
      # puts digits.each_slice(digits.count/2).map(&:join).inspect
      next digits.each_slice(digits.count/2).map(&:join).map(&:to_i) if digits.count % 2 == 0
      next stone * 2024
    end
  end
end
