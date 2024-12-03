require 'pry'

list1 = []
list2 = []

File.open('jour-01/input.txt', 'r').each do |line|
  first, last = line.split(' ').map(&:to_i)
  list1 << first
  list2 << last
end

list1.sort!
list2.sort!

solution = list1.zip(list2).sum do |first, last|
  [first, last].max - [first, last].min
end

puts 'Solution: ' + solution.to_s
