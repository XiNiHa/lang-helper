%%raw(`import "./tailwind.css"`)

module Router = {
  type screen =
    | Gallery
    | ItemView

  @react.component
  let make = () => {
    let (screen, setScreen) = React.useState(() => Gallery)
    let (index, setIndex) = React.useState(() => 0)
    let selectItem = index => {
      setScreen(_ => ItemView)
      setIndex(_ => index)
      ()
    }
    let onBack = () => {
      setScreen(_ => Gallery)
      ()
    }
    let title = () => switch screen {
    | Gallery => `갤러리`
    | ItemView => `상세보기`
    }

    <Layout title=title() withBack={screen === ItemView} onBack>
      {switch screen {
      | Gallery => <Gallery items=Item.items selectItem />
      | ItemView => <ItemView items=Item.items initialIndex=index />
      }}
    </Layout>
  }
}

ReactDOM18.renderConcurrentRootAtElementWithId(<Router />, "app")
