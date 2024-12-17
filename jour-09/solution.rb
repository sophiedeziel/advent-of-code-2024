
class Solution < BaseSolution
  puts "jour-09"
  def initialize(input_mode)
    @input = File.open("jour-09/#{input_mode}.txt", 'r').first.chomp.split('').map(&:to_i)
  end

  def part1
    disk = @input.each_with_index.flat_map do |number, index|
      if index % 2 == 0
        Array.new(number, index / 2)
      else
        Array.new(number, nil)
      end
    end

    set_size disk.compact.count

    defraged = []

    while disk.any?
      while disk[0] != nil
        defraged << disk.delete_at(0)
      end

      while disk.last == nil && disk.any?
        disk.pop
      end

      disk.delete_at(0)
      defraged << disk.pop if disk.any?
    end

    defraged.each_with_index.sum do |number, index|
      number * index
    end
  end

  def part2

  end

  private

  def compact?(disk)
    @current = first_nil_index(disk)
    tick
    last_number_index(disk) < first_nil_index(disk)
  end

  def last_number_index(disk)
    disk.rindex{|x| !x.nil?}
  end

  def first_nil_index(disk)
    disk.index(nil)
  end
end
