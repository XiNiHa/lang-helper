@react.component
let make = (~children, ~index, ~setIndex, ~itemsCount, ~onIndexUpdate=?) => {
  let (offset, setOffset) = React.useState(() => 0.)
  let (down, setDown) = React.useState(() => false)
  let (touchStartX, setTouchStartX) = React.useState(() => 0.)

  let screenWidth = Webapi.Dom.window->Webapi.Dom.Window.innerWidth->Belt.Int.toFloat

  let containerStyle = () =>
    ReactDOM.Style.make(
      ~transform=`translateX(${((index->Belt.Int.toFloat *. screenWidth +. offset) *. -1.)
          ->Js.Float.toString}px)`,
      ~transition=down ? "" : `transform ease-out .4s`,
      (),
    )

  let onContainerDown = e => {
    ReactEvent.Synthetic.preventDefault(e)
    setDown(_ => true)
  }
  let onContainerTouchStart = e => {
    let screenX = ReactEvent.Touch.touches(e)["0"]["screenX"]
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
      let screenX = ReactEvent.Touch.touches(e)["0"]["screenX"]
      setOffset(_ => touchStartX -. screenX)
    }
  }
  let onContainerUp = e => {
    ReactEvent.Synthetic.preventDefault(e)
    setDown(_ => false)

    if Js.Math.abs_float(offset) > screenWidth *. 0.2 {
      setIndex(prev => {
        let newIndex =
          offset > 0. ? Js.Math.min_int(prev + 1, itemsCount) : Js.Math.max_int(prev - 1, 0)
        switch onIndexUpdate {
        | Some(fn) => fn(newIndex)
        | None => ()
        }
        newIndex
      })
    }
    setOffset(_ => 0.)
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
    {children}
  </div>
}
