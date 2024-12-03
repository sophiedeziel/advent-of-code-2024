

list1 = []
list2 = []

File.open('jour-01/input.txt', 'r').each do |line|
  first, last = line.split(' ').map(&:to_i)
  list1 << first
  list2 << last
end

list1.sort!
list2.sort!

total_distance = list1.zip(list2).sum do |first, last|
  [first, last].max - [first, last].min
end

puts 'Partie 1: ' + total_distance.to_s

similarity_score = list1.sum do |number|
  number * list2.count(number)
end

puts 'Partie 2: ' + similarity_score.to_s
