@val external screenWidth: float = "innerWidth"

@react.component
let make = (~items: array<Item.t>, ~initialIndex: int) => {
  let (index, setIndex) = React.useState(() => initialIndex)
  let (offset, setOffset) = React.useState(() => 0.)
  let (down, setDown) = React.useState(() => false)
  let (audio, _) = React.useState(() => Audio.make(items[index].audioSrc))
  React.useEffect1(() => Some(() => Audio.pause(audio)), [])
  let (playing, setPlaying) = React.useState(() => false)
  let (percentage, setPercentage) = React.useState(() => 0.)
  let (touchStartX, setTouchStartX) = React.useState(() => 0.)

  let containerStyle = () =>
    ReactDOM.Style.make(
      ~transform=`translateX(${((index->Belt.Int.toFloat *. screenWidth +. offset) *. -1.)
          ->Js.Float.toString}px)`,
      ~transition=down ? "" : `transform ease-out .4s`,
      (),
    )
  let indicatorStyle = () => ReactDOM.Style.make(~left=j`$percentage%`, ())

  let onContainerDown = e => {
    ReactEvent.Synthetic.preventDefault(e)
    setDown(_ => true)
  }
  let onContainerTouchStart = e => {
    let screenX = %raw(`e.touches[0].screenX`)
    setTouchStartX(_ => screenX)
    onContainerDown(e)
  }
  let onContainerMove = e => {
    if down && touchStartX === 0. {
      let moved = ReactEvent.Mouse.movementX(e)->Belt.Int.toFloat
      setOffset(prev => prev -. moved)
    }
  }
  let onContainerTouchMove = e => {
    if down {
      let screenX = %raw(`e.touches[0].screenX`)
      setOffset(_ => touchStartX -. screenX)
    }
  }
  let onContainerUp = e => {
    ReactEvent.Synthetic.preventDefault(e)
    setDown(_ => false)

    if Js.Math.abs_float(offset) > screenWidth *. 0.2 {
      setIndex(prev => {
        let newIndex =
          offset > 0.
            ? Js.Math.min_int(prev + 1, Js.Array2.length(items))
            : Js.Math.max_int(prev - 1, 0)
        Audio.pause(audio)
        audio.src = items[newIndex].audioSrc
        setPlaying(_ => false)
        setPercentage(_ => 0.)

        newIndex
      })
    }
    setOffset(_ => 0.)
  }

  let audioClick = e => {
    switch playing {
    | true => {
        setPlaying(_ => false)
        Audio.pause(audio)
      }
    | false => {
        setPlaying(_ => true)
        Audio.play(audio)
      }
    }
  }

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

  let timeClickHandle = (clientX, barWidth) => {
    let leftMargin = (screenWidth -. barWidth) /. 2.
    let percentage = (clientX -. leftMargin) /. barWidth *. 100.
    setPercentage(_ => percentage)
    audio.currentTime =
      Js.Math.ceil_float(audio.duration *. (percentage /. 100.))
    if !playing {
      Audio.play(audio)
      setPlaying(_ => true)
    }
  }
  let onTimeClick = e => {
    let clientX = ReactEvent.Mouse.clientX(e)->Belt.Int.toFloat
    let barWidth = ReactEvent.Mouse.target(e)["clientWidth"]
    timeClickHandle(clientX, barWidth)
  }
  let onTimeTouchStart = e => {
    let clientX = %raw(`e.touches[0].clientX`)
    let barWidth = ReactEvent.Touch.target(e)["clientWidth"]
    timeClickHandle(clientX, barWidth)
  }
  let isPortrait = %raw(`window.innerWidth < window.innerHeight`)

  <div
    className="flex-grow flex overflow-visible flex-nowrap items-stretch h-full"
    style={containerStyle()}
    onMouseDown=onContainerDown
    onMouseUp=onContainerUp
    onMouseLeave=onContainerUp
    onMouseMove=onContainerMove
    onTouchStart=onContainerTouchStart
    onTouchEnd=onContainerUp
    onTouchCancel=onContainerUp
    onTouchMove=onContainerTouchMove>
    {items
    ->Js.Array2.mapi((item, index) =>
      <div key=j`$index` className="w-screen flex-shrink-0 flex flex-col items-stretch">
        <img
          src=item.imageSrc
          className="max-w-full object-contain mb-4 flex-grow"
          style={ReactDOM.Style.make(~maxHeight=isPortrait ? "50vh" : "80vh", ())}
        />
        <div className="mx-6 flex justify-between items-center">
          <i className={`fas mr-6 ${playing ? "fa-pause" : "fa-play"}`} onClick=audioClick onTouchEnd=audioClick />
          <div
            className="h-16 bg-white py-8 flex-grow"
            onClick=onTimeClick
            onTouchStart=onTimeTouchStart>
            <div className="w-full h-px bg-gray-700 relative">
              <div
                className="absolute w-6 h-6 -top-3 -ml-3 rounded-xl bg-gray-400 shadow-lg"
                style={indicatorStyle()}
              />
            </div>
          </div>
        </div>
        <audio src=item.audioSrc />
      </div>
    )
    ->React.array}
  </div>
}
