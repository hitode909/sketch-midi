require 'bundler'

Bundler.require

require 'shellwords'

module AppleScript
  def self.stroke key
      system <<"EOF"
osascript -e 'tell application "System Events"
  keystroke "#{ key }"
  keystroke return
end tell'
EOF
  end

  def self.activate application
    system %Q|osascript -e 'activate application "#{ application }"'|
  end

  def self.paste text
    system %Q(echo "#{ text }\\c" | pbcopy && osascript -e 'tell application "System Events" to keystroke "v" using {command down}')
  end
end

class Observer
  def initialize
    @handlers = {}
  end

  def on event, &handler
    @handlers[event] = handler
  end

  def watch input
    loop {
      events = input.gets
      events.each{|event|
        data = event[:data]

        handler = @handlers[data]
        next unless handler
        handler.call
      }
    }
  end
end

input = UniMIDI::Input.first.open

observer = Observer.new

observer.on [151, 26, 127] { AppleScript.stroke ':ok_man:' }
observer.on [151, 27, 127] { AppleScript.stroke ':innocent:' }
observer.on [151, 29, 127] { AppleScript.stroke ':pray:' }
observer.on [151, 30, 127] { AppleScript.stroke ':shipit:' }
observer.on [152, 30, 127] { AppleScript.stroke 'git fetch' }
observer.on [184, 25, 0]   { AppleScript.stroke 'git pull' }
observer.on [184, 25, 127] { AppleScript.stroke 'git push' }
observer.on [152, 26, 127] { AppleScript.paste  '助かった' }
observer.on [152, 27, 127] { AppleScript.paste  'じゃあそれで' }
observer.on [152, 29, 127] { AppleScript.paste  '飲みに行くぞ' }

observer.on [182, 23, 0]   { AppleScript.activate 'Google Chrome' }
observer.on [182, 23, 32]  { AppleScript.activate 'Emacs' }
observer.on [182, 23, 64]  { AppleScript.activate 'iTerm' }
observer.on [182, 23, 96]  { AppleScript.activate 'YoruFukurou' }
observer.on [182, 23, 127] { AppleScript.activate 'Slack' }

observer.watch input
