open Belt

module Fetch = Webapi.Fetch
module Request = Fetch.Request
module Response = Fetch.Response
module ResponseInit = Fetch.ResponseInit

let getEachWords = (ns, keys) =>
  keys
  ->Array.map(key => Kv.readJson(~namespace=ns, ~key, ())->Promise.thenResolve(json => (key, json)))
  ->Promise.all
  ->Promise.thenResolve(Js.Dict.fromArray)

let get: Router.Route.handler = (request, env) => {
  let params =
    request
    ->Request.url
    ->Webapi.Url.make
    ->Webapi.Url.searchParams
    ->Webapi.Url.URLSearchParams.entries
    ->Js.Array.from
    ->Js.Dict.fromArray

  let limit = params->Js.Dict.get("limit")->Option.flatMap(Int.fromString)
  let cursor = params->Js.Dict.get("cursor")

  Kv.list(~namespace=env.words, ~opts=Kv.List.makeOpts(~limit, ~cursor, ()), ())
  ->Promise.then(list => {
    let keys = list.keys->Array.map(key => key.name)
    keys->getEachWords(env.words, _)->Promise.thenResolve(words => (list, keys, words))
  })
  ->Promise.thenResolve(((list, keys, words)) => {
    {"keys": keys, "words": words, "cursor": list.cursor, "listEnd": list.list_complete}
    ->Js.Json.stringifyAny
    ->Option.getExn
    ->Response.makeWithInit(
      ResponseInit.make(~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}), ()),
    )
  })
}
