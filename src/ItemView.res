@bs.val external screenWidth: float = "innerWidth"

@react.component
let make = (~items: array<Item.t>, ~initialIndex: int) => {
  let (index, setIndex) = React.useState(() => initialIndex)
  let (offset, setOffset) = React.useState(() => 0.)
  let (down, setDown) = React.useState(() => false)
  let style = () =>
    ReactDOM.Style.make(
      ~transform=`translateX(${((index->Belt.Int.toFloat *. screenWidth +. offset) *. -1.)
          ->Js.Float.toString}px)`,
      ~transition=down ? "" : `transform ease-out .4s`,
      (),
    )

  let handleLeave = () => {
    setDown(_ => false)

    if Js.Math.abs_float(offset) > screenWidth *. 0.4 {
      setIndex(prev =>
        offset > 0.
          ? Js.Math.min_int(prev + 1, Js.Array2.length(items))
          : Js.Math.max_int(prev - 1, 0)
      )
    }
    setOffset(_ => 0.)
  }

  let onMouseDown = e => {
    ReactEvent.Mouse.preventDefault(e)
    setDown(_ => true)
  }
  let onMouseUp = e => {
    ReactEvent.Mouse.preventDefault(e)
    handleLeave()
  }
  let onMouseLeave = e => {
    ReactEvent.Mouse.preventDefault(e)
    handleLeave()
  }
  let onMouseMove = e => {
    if down {
      let moved = ReactEvent.Mouse.movementX(e)->Belt.Int.toFloat
      setOffset(prev => prev -. moved)
    }
  }

  <div
    className="flex-grow flex overflow-visible flex-nowrap items-stretch h-full"
    style={style()}
    onMouseDown
    onMouseUp
    onMouseLeave
    onMouseMove>
    {items
    ->Js.Array2.map(item =>
      <div className="w-screen flex-shrink-0">
        <img src=item.imageSrc className="w-screen h-64 object-contain mb-4" />
      </div>
    )
    ->ReasonReact.array}
  </div>
}
