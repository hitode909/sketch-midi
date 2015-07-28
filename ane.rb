require 'bundler'

Bundler.require

input = UniMIDI::Input.first.open

loop {
  events = input.gets
  events.each{|event|
    data = event[:data]
    next unless data[0] == 182
    size = data[2] / 127.0 * 30
    puts '姉' * size
  }
}
