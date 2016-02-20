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

def speed_factor
  1.0 + (rand - 0.5) / 35.0
end

parts = {
  tr8.bass_drum       => ['1010000000100000', speed_factor, 0],
  tr8.snare_drum      => ['0000100001001000', speed_factor, 0],
  tr8.mid_tom         => ['0000000000100000', speed_factor, 0],
  tr8.high_tom        => ['0000100100000000', speed_factor, 0],
  tr8.rim_shot        => ['0010000100000000', speed_factor, 0],
  tr8.hand_clap       => ['0000000000001000', speed_factor, 0],
  tr8.closed_high_hat => ['0111011101110111', speed_factor, 0],
  tr8.open_high_hat   => ['1000100010001000', speed_factor, 0],
}

start_at = Time.now.to_f
loop {
  i = start_at - Time.now.to_f

  parts.each{|part, part_def|
    score, speed, last_step = *part_def
    notes = score.split(//)
    current_step = ((i*speed * 6) % notes.length).to_i
    if current_step != last_step
      velocity = notes[current_step]
      output.puts(NOTE_ON, part, velocity.to_i * 100)
      print  part.chr
      part_def[2] = current_step
    end
  }

  sleep 0.01
}
