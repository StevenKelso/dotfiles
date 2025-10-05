-- Allow volume over 100%
apply_properties = {
  ["audio.allowed-rates"] = "48000,44100",
  ["audio.format"] = "F32",
  ["audio.sink-properties"] = {
    ["volume.max"] = 1.5,
    ["volume.norm"] = 1.0,
  },
  ["session.suspend-timeout-seconds"] = 5,
}
