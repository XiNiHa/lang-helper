module Fetch = Webapi.Fetch
module Request = Fetch.Request
module RequestInit = Fetch.RequestInit
module Response = Fetch.Response
module ResponseInit = Fetch.ResponseInit
module Url = Webapi.Url

type exports = {fetch: (Request.t, Env.t) => Promise.t<Response.t>}

let default = {
  fetch: (request, env) => {
    let defs = Js.Dict.fromArray([
      ("/words", Router.Route.make(~get=Words.get, ())),
      ("/assets", Router.Route.make(~get=Assets.get, ())),
    ])
    Router.execute(request, env, defs)
  },
}
