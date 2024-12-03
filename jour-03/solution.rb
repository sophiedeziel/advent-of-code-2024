
class Solution < BaseSolution
  puts "jour-03"
  def initialize(input_mode)
    @input = File.open("jour-03/#{input_mode}.txt", 'r').read

    @sum = 0
    @filtered_sum = 0
    enabled = true
    @input.scan(/mul\((\d+),(\d+)\)|(do\(\))|(don't\(\))/).each do |list|
      case list
      in [nil, nil, "do()", nil]
        enabled = true
      in [nil, nil, nil, "don't()"]
        enabled = false
      in [String, String, nil, nil]
        first, last = list.map(&:to_i)
        @sum += first.to_i * last.to_i
        @filtered_sum += first.to_i * last.to_i if enabled
      end
    end
  end

  def part1
    @sum
  end

  def part2
    @filtered_sum
  end
end
