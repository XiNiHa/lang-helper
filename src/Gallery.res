open Belt

@react.component
let make = (~words: array<Word.t>, ~selectWord: int => unit) => {
  <div className="container mx-auto p-4 flex flex-wrap">
    {words
    ->Array.mapWithIndex((index, word) =>
      <img
        crossOrigin="anonymous"
        key=word.image
        className="w-1/3 p-1 object-cover h-24 sm:h-48"
        src={word.image->Word.getAssetUrl}
        onClick={_ => selectWord(index)}
      />
    )
    ->React.array}
  </div>
}
