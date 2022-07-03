include ReactDOM.Experimental

@module("react-dom/client")
external createRoot: Dom.element => root = "createRoot"

@val @return(nullable)
external getElementById: string => option<Dom.element> = "document.getElementById"

let renderConcurrentRootAtElementWithId: (React.element, string) => unit = (content, id) =>
  switch getElementById(id) {
  | None =>
    raise(
      Invalid_argument(
        "ReactExperimental.renderConcurrentRootAtElementWithId : no element of id " ++
        id ++ " found in the HTML.",
      ),
    )
  | Some(element) => createRoot(element)->render(content)
  }

let throwPromise: Promise.t<'a> => unit = p => {
  let impl = %raw(`function (p) { throw p }`)
  impl(p)
}
