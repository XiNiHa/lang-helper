type t = Webapi.Fetch.Response.t

@new external makeWithStream: Webapi.ReadableStream.t => t = "Response"
@new
external makeWithStreamInit: (Webapi.ReadableStream.t, Webapi.Fetch.responseInit) => t = "Response"
