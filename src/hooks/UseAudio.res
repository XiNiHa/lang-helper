type t = {
  isPlaying: bool,
  percentage: float,
  play: unit => unit,
  pause: unit => unit,
  stop: unit => unit,
  setSrc: string => unit,
  setTimePercentage: float => unit,
}

let use = initialSrc => {
  let (audio, _) = React.useState(() => Audio.make(initialSrc))
  let (isPlaying, setPlaying) = React.useState(() => false)
  let (percentage, setPercentage) = React.useState(() => 0.)

  let play = () => {
    setPlaying(_ => true)
    Audio.play(audio)
  }
  let pause = () => {
    setPlaying(_ => false)
    Audio.pause(audio)
  }
  let stop = () => {
    setPlaying(_ => false)
    Audio.pause(audio)
    audio.currentTime = 0.
  }
  let setSrc = newSrc => {
    pause()
    audio.src = newSrc
    setPercentage(_ => 0.)
  }
  let setTimePercentage = newPercentage => {
    setPercentage(_ => newPercentage)
    audio.currentTime = Js.Math.ceil_float(audio.duration *. (percentage /. 100.))
    if !isPlaying {
      play()
    }
  }
  React.useEffect1(() => Some(() => pause()), [])

  let onAudioDone = _ => setPlaying(_ => false)
  React.useEffect(() => {
    Audio.addEventListener(audio, "ended", onAudioDone)

    Some(() => Audio.removeEventListener(audio, "ended", onAudioDone))
  })

  let onTimeUpdate = _ => setPercentage(_ => audio.currentTime /. audio.duration *. 100.)
  React.useEffect(() => {
    Audio.addEventListener(audio, "timeupdate", onTimeUpdate)

    Some(() => Audio.removeEventListener(audio, "timeupdate", onTimeUpdate))
  })

  {
    isPlaying: isPlaying,
    percentage: percentage,
    play: play,
    pause: pause,
    stop: stop,
    setSrc: setSrc,
    setTimePercentage: setTimePercentage,
  }
}
