
reports = File.open('jour-02/input.txt', 'r').map do |line|
  line.split(' ').map(&:to_i)
end.compact

changes = reports.count do |line|
  changes = line.each_cons(2).map do |first, last|
    next if last.nil? || first.nil?
    last - first
  end

  next false if changes.any? { |change| change.abs < 1 || change.abs > 3 }
  next false unless changes.all?(&:positive?) || changes.all?(&:negative?)

  true
end

puts "Partie 1: " + changes.to_s
