@bs.val external screenWidth: float = "innerWidth"
@bs.new external newAudio: string => 'a = "Audio"

@react.component
let make = (~items: array<Item.t>, ~initialIndex: int) => {
  let (index, setIndex) = React.useState(() => initialIndex)
  let (offset, setOffset) = React.useState(() => 0.)
  let (down, setDown) = React.useState(() => false)
  let (audio, _) = React.useState(() => newAudio(items[index].audioSrc))
  React.useEffect1(() => Some(() => audio["pause"]()), [])
  let (playing, setPlaying) = React.useState(() => false)
  let (percentage, setPercentage) = React.useState(() => 0.)
  let (audioDownX, setAudioDownX) = React.useState(() => 0)
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

    if Js.Math.abs_float(offset) > screenWidth *. 0.4 {
      setIndex(prev => {
        let newIndex =
          offset > 0.
            ? Js.Math.min_int(prev + 1, Js.Array2.length(items))
            : Js.Math.max_int(prev - 1, 0)
        audio["pause"]()
        audio["src"] = items[newIndex].audioSrc
        setPlaying(_ => false)
        setPercentage(_ => 0.)

        newIndex
      })
    }
    setOffset(_ => 0.)
  }

  let onAudioDown = e => {
    let clientX = ReactEvent.Mouse.clientX(e)
    setAudioDownX(_ => clientX)
  }
  let onAudioTouchStart = e => {
    let clientX = %raw(`e.touches[0].clientX`)
    setAudioDownX(_ => clientX)
  }
  let audioUpHandle = clientX => {
    let offset = Js.Math.abs_int(audioDownX - clientX)
    if offset < screenWidth->Belt.Float.toInt / 6 {
      switch playing {
      | true => {
          setPlaying(_ => false)
          audio["pause"]()
          audio["currentTime"] = 0
        }
      | false => {
          setPlaying(_ => true)
          audio["play"]()
        }
      }
    }
  }
  let onAudioUp = e => {
    let clientX = ReactEvent.Mouse.clientX(e)
    audioUpHandle(clientX)
  }
  let onAudioTouchEnd = e => {
    let clientX = %raw(`e.changedTouches[0].clientX`)
    audioUpHandle(clientX)
  }

  let onAudioDone = _ => setPlaying(_ => false)
  React.useEffect(() => {
    audio["addEventListener"]("ended", onAudioDone)

    Some(() => audio["removeEventListener"]("ended", onAudioDone))
  })

  let onTimeUpdate = _ => setPercentage(_ => audio["currentTime"] /. audio["duration"] *. 100.)
  React.useEffect(() => {
    audio["addEventListener"]("timeupdate", onTimeUpdate)

    Some(() => audio["removeEventListener"]("timeupdate", onTimeUpdate))
  })

  let timeClickHandle = (clientX, barWidth) => {
    let leftMargin = (screenWidth -. barWidth) /. 2.
    let percentage = (clientX -. leftMargin) /. barWidth *. 100.
    setPercentage(_ => percentage)
    audio["currentTime"] =
      Js.Math.ceil_float(audio["duration"] *. (percentage /. 100.))->Belt.Int.fromFloat
    if !playing {
      audio["play"]()
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
        <img src=item.imageSrc className="h-64 object-contain mb-4" />
        <div
          className="h-52 mx-4 p-4 shadow-lg flex items-center justify-center rounded-md bg-green-500 sm:mx-40"
          onMouseDown=onAudioDown
          onMouseUp=onAudioUp
          onTouchStart=onAudioTouchStart
          onTouchEnd=onAudioTouchEnd
          onTouchCancel=onAudioTouchEnd>
          <span className="text-3xl text-white font-semibold">
            {React.string(playing ? `소리 멈추기` : `소리 재생하기`)}
          </span>
        </div>
        <div className="mx-6 h-16 bg-white py-8" onClick=onTimeClick onTouchStart=onTimeTouchStart>
          <div className="w-full h-px bg-gray-700 relative">
            <div
              className="absolute w-6 h-6 -top-3 -ml-3 rounded-xl bg-gray-400 shadow-lg"
              style={indicatorStyle()}
            />
          </div>
        </div>
      </div>
    )
    ->ReasonReact.array}
  </div>
}
