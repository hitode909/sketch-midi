class TR8
  def bass_drums
    [35, 36]
  end

  def snare_drums
    [38, 40]
  end

  # different from document? low toms should play on 41, 43
  def low_toms
    [43]
  end

  def mid_toms
    [47]
  end

  def high_toms
    [50]
  end

  def rim_shots
    [37]
  end

  def hand_claps
    [39]
  end

  def closed_high_hats
    [42,44]
  end

  def open_high_hats
    [46]
  end

  def crash_cymbals
    [49]
  end

  def ride_cymbals
    [51]
  end

  def all_parts
    [
      bass_drum,
      snare_drum,
      low_tom,
      mid_tom,
      high_tom,
      rim_shot,
      hand_clap,
      closed_high_hat,
      open_high_hat,
      crash_cymbal,
      ride_cymbal,
    ]
  end

  self.instance_methods(false).each{|plural|
    singular = plural.to_s.sub(/s$/, '')
    define_method(singular) {
      send(plural).first
    }
  }
end
