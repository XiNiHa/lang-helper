type t

module Object = {
  type t

  @get external key: t => string = "key"
  @get external version: t => string = "version"
  @get external size: t => float = "size"
  @get external etag: t => string = "etag"
  @get external httpEtag: t => string = "httpEtag"
  @get external uploaded: t => Js.Date.t = "uploaded"
  // TODO: add bindings for R2HttpMetadata
  // @get external httpMetadata: t => HttpMetadata.t = "httpMetadata"
  @get external customMetadata: t => Js.Dict.t<string> = "customMetadata"
  // TODO: add bindings for R2Range
  // @get external range: t => Range.t = "range"
  // @send external writeHttpMetadata: (t, Headers.t) => void = "writeHttpMetadata";
}

module ObjectBody = {
  type t

  external object: t => Object.t = "%identity"

  @get external body: t => Webapi.ReadableStream.t = "body"
  @get external bodyUsed: t => bool = "bodyUsed"
  @send external arrayBuffer: t => Promise.t<Js.TypedArray2.ArrayBuffer.t> = "arrayBuffer"
  @send external text: t => Promise.t<string> = "text"
  @send external json: t => Promise.t<Js.Json.t> = "json"
  @send external blob: t => Promise.t<Webapi.Blob.t> = "blob"
}

module List = {
  type opts
  type objects = {
    objects: array<Object.t>,
    truncated: bool,
    cursor: option<string>,
    delimitedPrefixes: array<string>,
  }

  @obj
  external makeOpts: (
    ~limit: option<int>=?,
    ~prefix: option<string>=?,
    ~cursor: option<string>=?,
    ~delimiter: option<string>=?,
    // TODO: I don't want to spend time for something that I'm not interested in right now.
    // Marking this as TODO since adding this requires building a wrapper makeOpts function.
    // ~include: option<array<#httpMetadata | #customMetadata>>
    unit,
  ) => opts = ""

  @send external list: (~bucket: t, ~opts: opts=?, unit) => Promise.t<objects> = "list"
}

module Get = {
  type opts

  // TODO: implement options binding

  @send external get: (~bucket: t, ~key: string) => Promise.t<option<ObjectBody.t>> = "get"
  // @send external getWithOpts: (~bucket: t, ~key: string, ~opts: opts=?, unit) => Promise.t<Object.t> = "get"
}

module Put = {
  type opts

  @obj
  external makeOpts: (
    // TODO: add bindings for R2HttpMetadata
    // ~httpMetadata: HttpMetadata.t=?
    ~customMetadata: Js.Dict.t<string>=?,
    ~md5: Js.TypedArray2.ArrayBuffer.t=?,
    ()
  ) => opts = ""

  @send
  external putReadableStream: (
    ~bucket: t,
    ~key: string,
    ~body: Webapi.ReadableStream.t,
    ~opts: opts=?,
    unit,
  ) => Promise.t<Object.t> = "put"
  @send
  external putArrayBuffer: (
    ~bucket: t,
    ~key: string,
    ~body: Js.TypedArray2.ArrayBuffer.t,
    ~opts: opts=?,
    unit,
  ) => Promise.t<Object.t> = "put"
  @send
  external putString: (
    ~bucket: t,
    ~key: string,
    ~body: string,
    ~opts: opts=?,
    unit,
  ) => Promise.t<Object.t> = "put"
  @send
  external putNull: (
    ~bucket: t,
    ~key: string,
    ~body: unit=?,
    ~opts: opts=?,
    unit,
  ) => Promise.t<Object.t> = "put"
  @send
  external putBlob: (
    ~bucket: t,
    ~key: string,
    ~body: Webapi.Blob.t,
    ~opts: opts=?,
    unit,
  ) => Promise.t<Object.t> = "put"
}

module Delete = {
  @send external delete: (~bucket: t, ~key: string, unit) => Promise.t<unit> = "delete"
}

let list = List.list

let get = Get.get
// let getWithOpts = Get.getWithOpts

let putReadableStream = Put.putReadableStream
let putArrayBuffer = Put.putArrayBuffer
let putString = Put.putString
let putNull = Put.putNull
let putBlob = Put.putBlob

let delete = Delete.delete
