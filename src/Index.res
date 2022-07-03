%%raw(`import "./tailwind.css"`)

open Belt

module Router = {
  type screen =
    | Gallery
    | ItemView(int)
    | Form

  @react.component
  let make = () => {
    let (screen, setScreen) = React.useState(() => Gallery)
    let (words, reset) = UseWords.use()
    let selectWord = index => setScreen(_ => ItemView(index))
    let onBack = () => setScreen(_ => Gallery)
    let onAdd = () => setScreen(_ => Form)
    let onAddDone = () => {
      reset()
      setScreen(_ => Gallery)
    }
    let title = () =>
      switch screen {
      | Gallery => `갤러리`
      | ItemView(_) => `상세보기`
      | Form => `항목 추가`
      }

    let showBack = switch screen {
    | Gallery => false
    | _ => true
    }

    <Layout title={title()} withBack={showBack} onBack onAdd>
      {
        let words = words->Option.map(words => words.words->Js.Dict.values)->Option.getExn

        switch screen {
        | Gallery => <Gallery words selectWord />
        | ItemView(index) => <WordView words initialIndex=index />
        | Form => <Form onAddDone />
        }
      }
    </Layout>
  }
}

ReactDOM18.renderConcurrentRootAtElementWithId(
  <React.Suspense fallback={React.string("Loading...")}> <Router /> </React.Suspense>,
  "app",
)
