
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

    checksum(defraged)
  end

  def part2
    disk = []
    @input.each_with_index do |number, index|
      if index % 2 == 0
        disk << [number, index / 2]
      else
        disk << [number, nil]
      end
    end

    disk.dup.reverse.each do |number, id|
      next if id.nil?

      file_index = disk.index { |x, i| i == id}
      file = disk[file_index]

      spot = disk.first(file_index).index { |x, i| i.nil? && x >= number }
      next if spot.nil?

      next if spot >= file_index
      disk[file_index][1] = nil

      if disk[spot].first == number
        disk.delete_at(spot)
      else
        disk[spot][0] -= number
      end

      disk.insert(spot, [number, id])
    end
    checksum(disk.flat_map{|x, i| [i] * x})
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

  def checksum(defraged)
    defraged.each_with_index.sum do |number, index|
      (number || 0) * index
    end
  end
end
