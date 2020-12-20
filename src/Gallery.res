@react.component
let make = (~items: array<Item.t>, ~selectItem: int => unit) => {
  <div className="container mx-auto p-4 flex flex-wrap">
    {
      items
      -> Js.Array2.map(item => <img className="w-1/3 p-1 object-cover h-24" src=item.imageSrc onClick={(_) => selectItem(Js.Array2.indexOf(items, item))} />)
      -> React.array
    }
  </div>
}
