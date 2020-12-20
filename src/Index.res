%%raw(`require("./tailwind.css")`)

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

    <Layout title={`갤러리`} withBack={screen === ItemView} onBack>
      {switch screen {
      | Gallery => <Gallery items=Item.items selectItem />
      | ItemView => <ItemView items=Item.items initialIndex=index />
      }}
    </Layout>
  }
}

ReactDOMRe.renderToElementWithId(<Router />, "app")
