require 'bundler'

Bundler.require

require './tr8'
require 'pp'

output = UniMIDI::Output.find_by_name("Roland TR-8").open

tr8 = TR8.new

CHANNEL = 10
NOTE_ON = 0x90+CHANNEL-1
VELOCIT_MAX = 127

bps = 0

tr8.all_parts.each{|part|
  output.puts(NOTE_ON, part, 0)
}

parts = { }

i = 0
next_change = 0
loop {
  if i == next_change
    bps += 1
    p bps
    next_change += bps*4
    parts = { }
    tr8.all_parts.each{|part|
      parts[part] = (1..bps).map{|j|
        accent = rand
        accent += 0.4 if j == 1
        accent = 1.0 if accent > 1.0
        accent = 0.0 if accent < 0.5
        (VELOCIT_MAX * accent).to_i
      }
    }
    pp parts
  end

  i += 1

  parts.each{|part, velocities|
    part_index = i%bps
    velocity = velocities[part_index]
    output.puts(NOTE_ON, part, velocity)
  }

  sleep 0.8/bps

}
