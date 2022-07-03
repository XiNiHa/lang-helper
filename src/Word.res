let originUrl = "https://lang-helper-backend.xiniha.workers.dev"
let wordsUrl = `${originUrl}/words`
let getAssetUrl = filename => `${originUrl}/assets?name=${filename}`

type t = {
  name: string,
  image: string,
  audio: string,
}

type res = {
  keys: array<string>,
  words: Js.Dict.t<t>,
  cursor: string,
  listEnd: bool,
}

external toRes: Js.Json.t => res = "%identity"

let getWords = () =>
  Webapi.Fetch.fetch(wordsUrl)->Promise.then(Webapi.Fetch.Response.json)->Promise.thenResolve(toRes)
