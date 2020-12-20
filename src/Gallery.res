@react.component
let make = (~items: array<Item.t>, ~selectItem: int => unit) => {
  <div className="container mx-auto p-4 flex flex-wrap">
    {
      items
      -> Js.Array2.mapi((item, index) => <img key=j`$index` className="w-1/3 p-1 object-cover h-24 sm:h-48" src=item.imageSrc onClick={(_) => selectItem(index)} />)
      -> React.array
    }
  </div>
}
