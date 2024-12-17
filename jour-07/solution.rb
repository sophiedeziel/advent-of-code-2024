
class Solution < BaseSolution
  puts "jour-07"
  def initialize(input_mode)
    @input = File.open("jour-07/#{input_mode}.txt", 'r').map do |line|
      total, numbers = line.chomp.split(':')
      [total.to_i, numbers.split(' ').map(&:to_i)]
    end
  end

  # 3750514471 too low
  # 3600597604 too low
  # 93655130849 not right
  def part1
    set_size(@input.count)
    @input.sum do |total, numbers|
      tick
      (0...(2**(numbers.count - 1))).to_a.find do |i|
        operators = i.to_s(2).rjust((numbers.count - 1), "0").split('').map{ |c| c == '1' }
        first, *rest = numbers
        total == rest.inject(first) do |sum, number|
          operators.shift ? (sum + number) : (sum * number)
        end
      end.nil? ? 0 : total
    end
  end

  def part2
    set_size(@input.count)
    @input.sum do |total, numbers|
      tick
      (0...(3**(numbers.count - 1))).to_a.find do |i|
        operators = i.to_s(3).rjust((numbers.count - 1), "0").split('')
        first, *rest = numbers
        total == rest.inject(first) do |sum, number|
          break sum if sum > total
          case operators.shift
          when "0"
            (sum + number)
          when "1"
            (sum * number)
          when "2"
            (sum.to_s + number.to_s).to_i
          end
        end
      end.nil? ? 0 : total
    end
  end
end
