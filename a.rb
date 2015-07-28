require 'bundler'

Bundler.require

input = UniMIDI::Input.first.open

loop {
  p input.gets
}
