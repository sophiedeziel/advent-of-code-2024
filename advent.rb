require 'listen'
require 'pry'

listener = Listen.to('.', only: /\.rb$/) do |modified, added, removed|
  modified.each do |file|
    begin
      load(file)
    rescue => e
        puts e
    end
  end
end
listener.start
sleep
