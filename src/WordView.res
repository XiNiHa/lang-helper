open Belt

module Item = {
  @react.component
  let make = (~word: Word.t, ~active) => {
    let {play, pause, stop, setTimePercentage, isPlaying, percentage} = UseAudio.use(
      word.audio->Word.getAssetUrl,
    )

    React.useEffect1(() => {
      if !active {
        stop()
      }
      None
    }, [active])

    let indicatorStyle = () => ReactDOM.Style.make(~left=j`$percentage%`, ())

    let audioClick = _ => {
      switch isPlaying {
      | true => pause()
      | false => play()
      }
    }

    let timeClickHandle = (clientX, barWidth) => {
      let leftMargin =
        (Webapi.Dom.window->Webapi.Dom.Window.innerWidth->Belt.Int.toFloat -. barWidth) /. 2.
      let percentage = (clientX -. leftMargin) /. barWidth *. 100.
      setTimePercentage(percentage)
    }
    let onTimeClick = e => {
      let clientX = ReactEvent.Mouse.clientX(e)->Belt.Int.toFloat
      let barWidth = ReactEvent.Mouse.target(e)["clientWidth"]
      timeClickHandle(clientX, barWidth)
    }
    let onTimeTouchStart = e => {
      let clientX = ReactEvent.Touch.touches(e)["0"]["screenX"]
      let barWidth = ReactEvent.Touch.target(e)["clientWidth"]
      timeClickHandle(clientX, barWidth)
    }

    let isPortrait = {
      let window = Webapi.Dom.window
      let width = window->Webapi.Dom.Window.innerWidth
      let height = window->Webapi.Dom.Window.innerHeight
      width < height
    }

    <div className="w-screen flex-shrink-0 flex flex-col items-stretch">
      <img
        src={word.image->Word.getAssetUrl}
        className="max-w-full object-contain mb-4 flex-grow"
        style={ReactDOM.Style.make(~maxHeight=isPortrait ? "50vh" : "80vh", ())}
      />
      <div className="mx-6 flex justify-between items-center">
        <i
          className={`fas mr-6 ${isPlaying ? "fa-pause" : "fa-play"}`}
          onClick=audioClick
          onTouchEnd=audioClick
        />
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
      <audio src={word.audio->Word.getAssetUrl} />
    </div>
  }
}

@react.component
let make = (~words: array<Word.t>, ~initialIndex) => {
  let (index, setIndex) = React.useState(() => initialIndex)

  <Swiper index setIndex itemsCount={Array.length(words)}>
    {words
    ->Array.mapWithIndex((i, word) => <Item key=word.image word={word} active={index == i} />)
    ->React.array}
  </Swiper>
}
