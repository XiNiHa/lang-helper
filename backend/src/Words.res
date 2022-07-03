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
      ResponseInit.make(
        ~headers=Fetch.HeadersInit.makeWithArray(
          [("Content-Type", "application/json")]->Array.concat(Router.corsHeaders),
        ),
        (),
      ),
    )
  })
}

let post: Router.Route.handler = (request, env) => {
  request
  ->Request.formData
  ->Promise.then(data => {
    let name = data->Webapi.FormData.get("name")->Option.map(Webapi.FormData.EntryValue.classify)
    let image = data->Webapi.FormData.get("image")->Option.map(Webapi.FormData.EntryValue.classify)
    let audio = data->Webapi.FormData.get("audio")->Option.map(Webapi.FormData.EntryValue.classify)

    switch (name, image, audio) {
    | (Some(#String(name)), Some(#File(image)), Some(#File(audio))) => {
        let id =
          (Js.Date.now() *. 10000. +. Js.Math.random_int(0, 9999)->Belt.Int.toFloat)
            ->Belt.Float.toString

        let getExt = file => {
          let splitted = file->Webapi.File.name->Js.String2.split(".")
          splitted->Array.getExn(splitted->Array.length - 1)
        }

        let imageExt = getExt(image)
        let audioExt = getExt(audio)

        let imageKey = `${id}-image.${imageExt}`
        let audioKey = `${id}-audio.${audioExt}`

        (
          {"name": name, "image": imageKey, "audio": audioKey}
          ->Js.Json.stringifyAny
          ->Option.getExn
          ->Kv.putText(~namespace=env.words, ~key=id, ~value=_, ()),
          R2.putReadableStream(
            ~bucket=env.assets,
            ~key=imageKey,
            ~body=image->Webapi.File.stream,
            (),
          ),
          R2.putReadableStream(
            ~bucket=env.assets,
            ~key=audioKey,
            ~body=audio->Webapi.File.stream,
            (),
          ),
        )
        ->Promise.all3
        ->Promise.thenResolve(_ => {
          {"id": id}
          ->Js.Json.stringifyAny
          ->Option.getExn
          ->Response.makeWithInit(
            ResponseInit.make(
              ~headers=Fetch.HeadersInit.makeWithArray(
                [("Content-Type", "application/json")]->Array.concat(Router.corsHeaders),
              ),
              (),
            ),
          )
        })
      }
    | _ =>
      {"error": "invalid formData input"}
      ->Js.Json.stringifyAny
      ->Option.getExn
      ->Response.makeWithInit(
        ResponseInit.make(
          ~status=400,
          ~headers=Fetch.HeadersInit.makeWithArray(
            [("Content-Type", "application/json")]->Array.concat(Router.corsHeaders),
          ),
          (),
        ),
      )
      ->Promise.resolve
    }
  })
}
