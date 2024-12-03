
class Solution < BaseSolution
    puts "jour-01"
  def initialize(input_mode)
    list1 = []
    list2 = []

    File.open("jour-01/#{input_mode}.txt", 'r').each do |line|
      first, last = line.split(' ').map(&:to_i)
      list1 << first
      list2 << last
    end

    list1.sort!
    list2.sort!

    @total_distance = list1.zip(list2).sum do |first, last|
      [first, last].max - [first, last].min
    end

    @similarity_score = list1.sum do |number|
      number * list2.count(number)
    end
  end

  def part1
    @total_distance.to_s
  end

  def part2
    @similarity_score.to_s
  end
end
