
def safe?(*numbers)
  changes = numbers.each_cons(2).map do |first, last|
    next if last.nil? || first.nil?
    last - first
  end

  return false if changes.any? { |change| change.abs < 1 || change.abs > 3 }
  return false unless changes.all?(&:positive?) || changes.all?(&:negative?)
  true
end

reports = File.open('jour-02/input.txt', 'r').map do |line|
  line.split(' ').map(&:to_i)
end.compact

strict_safe = 0
tolerant_safe = 0

reports.each do |line|
  if safe?(*line)
   strict_safe += 1
   tolerant_safe += 1
  else
    tolerant_safe += 1 if (0...line.count).to_a.any? { |index| safe?(*(line.reject.with_index{|v, i| i == index })) }
  end
end

puts "Partie 1: " + strict_safe.to_s
puts "Partie 2: " + tolerant_safe.to_s
