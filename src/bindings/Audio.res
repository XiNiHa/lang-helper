type t = {
  mutable src: string,
  mutable currentTime: float,
  duration: float,
}
type event

@new external make: string => t = "Audio"
@send external play: t => unit = "play"
@send external pause: t => unit = "pause"
@send external addEventListener: (t, string, event => unit) => unit = "addEventListener"
@send external removeEventListener: (t, string, event => unit) => unit = "removeEventListener"
