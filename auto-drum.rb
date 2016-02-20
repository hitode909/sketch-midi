require 'bundler'

Bundler.require

require './tr8'
require 'pp'

output = UniMIDI::Output.find_by_name("Roland TR-8").open

tr8 = TR8.new

CHANNEL = 10
NOTE_ON = 0x90+CHANNEL-1
VELOCIT_MAX = 127

BPS = 8

tr8.all_parts.each{|part|
  output.puts(NOTE_ON, part, 0)
}

parts = { }

i = 0
loop {
  if i % 32 == 0
    parts = { }
    tr8.all_parts.each{|part|
      parts[part] = (1..BPS).map{|j|
        accent = rand
        accent += 0.3 if j == 1
        accent = 1.0 if accent > 1.0
        accent = 0.0 if accent < 0.5
        (VELOCIT_MAX * accent).to_i
      }
    }
    pp parts
  end

  i += 1
  part_index = i%BPS

  parts.each{|part, velocities|
    velocity = velocities[part_index]
    output.puts(NOTE_ON, part, velocity)
  }

  sleep 1.0/BPS
}
