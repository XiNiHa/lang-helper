@react.component
let make = (~title: string, ~children, ~withBack: bool, ~onBack: unit => unit) =>
  <div className="w-screen min-h-screen relative flex flex-col">
    <header className="w-screen shadow h-12 flex items-center justify-center font-bold sticky top-0 bg-white">
      {withBack
        ? <button
            className="absolute top-1/2 left-0 w-12 h-12 -mt-6 font-bold" onClick={_ => onBack()}>
            {React.string(`<`)}
          </button>
        : React.string("")}
      {React.string(title)}
    </header>
    <main className="flex-grow flex flex-col w-screen overflow-x-hidden"> children </main>
  </div>
