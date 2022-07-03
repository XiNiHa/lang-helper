open Belt

module Fetch = Webapi.Fetch
module Request = Fetch.Request
module Response = Fetch.Response
module ResponseInit = Fetch.ResponseInit

let get: Router.Route.handler = (request, env) => {
  let name =
    request
    ->Request.url
    ->Webapi.Url.make
    ->Webapi.Url.searchParams
    ->Webapi.Url.URLSearchParams.entries
    ->Js.Array.from
    ->Js.Dict.fromArray
    ->Js.Dict.get("name")

  switch name {
  | Some(key) =>
    R2.get(~bucket=env.assets, ~key)->Promise.thenResolve(body => {
      switch body {
      | Some(body) =>
        body
        ->R2.ObjectBody.body
        ->Response2.makeWithStreamInit(
          ResponseInit.make(
            ~headers=Fetch.HeadersInit.make({
              "etag": body->R2.ObjectBody.httpEtag,
            }),
            (),
          ),
        )
      | None =>
        {"error": "asset not found"}
        ->Js.Json.stringifyAny
        ->Option.getExn
        ->Response.makeWithInit(
          ResponseInit.make(
            ~status=404,
            ~headers=Fetch.HeadersInit.makeWithArray(
              [("Content-Type", "application/json")]->Array.concat(Router.corsHeaders),
            ),
            (),
          ),
        )
      }
    })
  | None =>
    {"error": "query param 'name' not provided"}
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
}
