module Fetch = Webapi.Fetch
module Request = Fetch.Request
module Response = Fetch.Response
module ResponseInit = Fetch.ResponseInit

module Route = {
  type handler = (Request.t, Env.t) => Promise.t<Response.t>
  type t = {
    get: option<handler>,
    post: option<handler>,
  }

  let make = (~get=?, ~post=?, ()) => {get: get, post: post}
}

type defs = Js.Dict.t<Route.t>

let corsHeaders = [("Access-Control-Allow-Origin", "*")]

let execute = (request, env, defs: defs) => {
  let url = request->Request.url->Webapi.Url.make
  let route = url->Webapi.Url.pathname->Js.Dict.get(defs, _)
  switch (route, request->Request.method_) {
  | (_, Options) =>
    Response.makeWithInit(
      "",
      ResponseInit.make(~headers=Fetch.HeadersInit.makeWithArray(corsHeaders), ()),
    )->Promise.resolve
  | (Some(route), method) => {
      let handler = switch method {
      | Get => route.get
      | Post => route.post
      | _ => None
      }

      switch handler {
      | Some(handler) => handler(request, env)
      | None => Response.makeWithInit("", ResponseInit.make(~status=405, ~headers=Fetch.HeadersInit.makeWithArray(corsHeaders), ()))->Promise.resolve
      }
    }
  | (None, _) => Response.makeWithInit("", ResponseInit.make(~status=404,~headers=Fetch.HeadersInit.makeWithArray(corsHeaders), ()))->Promise.resolve
  }
}
