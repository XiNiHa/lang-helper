%%raw(`import "./tailwind.css"`)

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
      {switch screen {
      | Gallery => <Gallery words=Word.words selectWord />
      | ItemView(index) => <WordView words=Word.words initialIndex=index />
      }}
    </Layout>
  }
}

ReactDOM18.renderConcurrentRootAtElementWithId(<Router />, "app")
