open Belt

type t

module List = {
  type opts
  type key = {name: string, expiration: int, metadata: Js.Dict.t<string>}
  type res = {keys: array<key>, list_complete: bool, cursor: string}

  @obj
  external makeOpts: (
    ~prefix: option<string>=?,
    ~limit: option<int>=?,
    ~cursor: option<string>=?,
    unit,
  ) => opts = ""

  @send external list: (~namespace: t, ~opts: opts=?, unit) => Promise.t<res> = "list"
}

module Read = {
  type opts = {cacheTtl: option<int>}
  type inneropts

  @obj
  external __makeOpts: (~\"type": option<string>=?, ~cacheTtl: option<int>=?, unit) => inneropts =
    ""

  let makeOpts = (~cacheTtl: option<int>=?, ()) => {
    {cacheTtl: cacheTtl}
  }

  @send
  external read: (~namespace: t, ~key: string, ~opts: inneropts=?, unit) => Promise.t<'a> = "get"

  let readText = (~namespace, ~key, ~opts=?, ()) => {
    let result: Promise.t<string> = read(
      ~namespace,
      ~key,
      ~opts=__makeOpts(
        ~\"type"=Some("text"),
        ~cacheTtl=opts->Option.flatMap(opts => opts.cacheTtl),
        (),
      ),
      (),
    )
    result
  }

  let readJson = (~namespace, ~key, ~opts=?, ()) => {
    let result: Promise.t<Js.Json.t> = read(
      ~namespace,
      ~key,
      ~opts=__makeOpts(
        ~\"type"=Some("json"),
        ~cacheTtl=opts->Option.flatMap(opts => opts.cacheTtl),
        (),
      ),
      (),
    )
    result
  }

  let readArrayBuffer = (~namespace, ~key, ~opts=?, ()) => {
    let result: Promise.t<Js.TypedArray2.ArrayBuffer.t> = read(
      ~namespace,
      ~key,
      ~opts=__makeOpts(
        ~\"type"=Some("arrayBuffer"),
        ~cacheTtl=opts->Option.flatMap(opts => opts.cacheTtl),
        (),
      ),
      (),
    )
    result
  }

  let readStream = (~namespace, ~key, ~opts=?, ()) => {
    let result: Promise.t<Webapi.ReadableStream.t> = read(
      ~namespace,
      ~key,
      ~opts=__makeOpts(
        ~\"type"=Some("stream"),
        ~cacheTtl=opts->Option.flatMap(opts => opts.cacheTtl),
        (),
      ),
      (),
    )
    result
  }
}

module Put = {
  type opts

  @obj
  external makeOpts: (
    ~expiration: option<int>=?,
    ~expirationTtl: option<int>=?,
    ~metadata: option<'a>=?,
    unit,
  ) => opts = ""

  @send
  external putText: (
    ~namespace: t,
    ~key: string,
    ~value: string,
    ~opts: option<opts>=?,
    unit,
  ) => Promise.t<unit> = "put"
  @send
  external putArrayBuffer: (
    ~namespace: t,
    ~key: string,
    ~value: Js.TypedArray2.ArrayBuffer.t,
    ~opts: option<opts>=?,
    unit,
  ) => Promise.t<unit> = "put"
  @send
  external putStream: (
    ~namespace: t,
    ~key: string,
    ~value: Webapi.ReadableStream.t,
    ~opts: option<opts>=?,
    unit,
  ) => Promise.t<unit> = "put"
}

module Delete = {
  @send external delete: (~namespace: t, ~key: string, unit) => Promise.t<unit> = "delete"
}

let list = List.list

let readText = Read.readText
let readJson = Read.readJson
let readArrayBuffer = Read.readArrayBuffer
let readStream = Read.readStream

let putText = Put.putText
let putArrayBuffer = Put.putArrayBuffer
let putStream = Put.putStream

let delete = Delete.delete
