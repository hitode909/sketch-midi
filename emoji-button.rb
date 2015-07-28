require 'bundler'

Bundler.require

input = UniMIDI::Input.first.open

loop {
  events = input.gets
  events.each{|event|
    data = event[:data]
    p data
    if data == [151, 26, 127]
      system %q|osascript -e 'tell application "System Events" to keystroke ":ok_man:"'|
      system %q|osascript -e 'tell application "System Events" to keystroke return'|
    elsif data == [151, 27, 127]
      system %q|osascript -e 'tell application "System Events" to keystroke ":innocent:"'|
      system %q|osascript -e 'tell application "System Events" to keystroke return'|
    elsif data == [151, 29, 127]
      system %q|osascript -e 'tell application "System Events" to keystroke ":pray:"'|
      system %q|osascript -e 'tell application "System Events" to keystroke return'|
    elsif data == [151, 30, 127]
      system %q|osascript -e 'tell application "System Events" to keystroke "LGTM"'|
      system %q|osascript -e 'tell application "System Events" to keystroke return'|
    elsif data == [184, 25, 0]
      system %q|osascript -e 'tell application "System Events" to keystroke "git pull"'|
      system %q|osascript -e 'tell application "System Events" to keystroke return'|
    elsif data == [184, 25, 127]
      system %q|osascript -e 'tell application "System Events" to keystroke "git push"'|
      system %q|osascript -e 'tell application "System Events" to keystroke return'|
    end
  }
}
