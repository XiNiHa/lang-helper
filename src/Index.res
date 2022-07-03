%%raw(`import "./tailwind.css"`)

open Belt

module Router = {
  type screen =
    | Gallery
    | ItemView(int)

  let isItemView = screen =>
    switch screen {
    | ItemView(_) => true
    | _ => false
    }

  @react.component
  let make = () => {
    let (screen, setScreen) = React.useState(() => Gallery)
    let words = UseWords.use()
    let selectWord = index => {
      setScreen(_ => ItemView(index))
    }
    let onBack = () => {
      setScreen(_ => Gallery)
    }
    let title = () =>
      switch screen {
      | Gallery => `갤러리`
      | ItemView(_) => `상세보기`
      }

    <Layout title={title()} withBack={isItemView(screen)} onBack>
      {
        let words = words->Option.map(words => words.words->Js.Dict.values)->Option.getExn

        switch screen {
        | Gallery => <Gallery words selectWord />
        | ItemView(index) => <WordView words initialIndex=index />
        }
      }
    </Layout>
  }
}

ReactDOM18.renderConcurrentRootAtElementWithId(
  <React.Suspense fallback={React.string("Loading...")}> <Router /> </React.Suspense>,
  "app",
)
