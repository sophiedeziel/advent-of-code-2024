require 'listen'
require 'pry'

system "clear"

listener = Listen.to('.', only: /\.rb$/) do |modified, added, removed|
  modified.each do |file|
    begin
      system "clear"
      puts "File: #{file}"
      load(file)
    rescue => e
        puts e
    end
  end
end
listener.start
sleep
