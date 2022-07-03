type state = Idle | Fetching | FetchError
type action = Fetch(Promise.t<unit>) | SetError | ResetError

let reducer = (state, action) => {
  switch (state, action) {
  | (Idle, Fetch(_)) => Fetching
  | (Fetching, SetError) => FetchError
  | (FetchError, ResetError) => Idle
  | _ => state
  }
}

@new external makeFormDataFromDomEl: Dom.element => Webapi.FormData.t = "FormData"
@get external value: Dom.element => string = "value"

@react.component
let make = (~onAddDone) => {
  let (state, action) = React.useReducer(reducer, Idle)
  let formEl: React.ref<Js.Nullable.t<Dom.element>> = React.useRef(Js.Nullable.null)
  let tokenEl: React.ref<Js.Nullable.t<Dom.element>> = React.useRef(Js.Nullable.null)

  let onSubmit = e => {
    ReactEvent.Form.preventDefault(e)
    let formData =
      formEl.current->Js.Nullable.toOption->Belt.Option.map(formEl => formEl->makeFormDataFromDomEl)

    switch formData {
    | Some(formData) =>
      Webapi.Fetch.fetchWithInit(
        Word.wordsUrl,
        Webapi.Fetch.RequestInit.make(
          ~method_=Webapi.Fetch.Post,
          ~body=Webapi.Fetch.BodyInit.makeWithFormData(formData),
          ~headers=Webapi.Fetch.HeadersInit.make({
            "Authorization": `Bearer ${tokenEl.current
              ->Js.Nullable.toOption
              ->Belt.Option.mapWithDefault("", tokenEl => tokenEl->value)}}`,
          }),
          (),
        ),
      )
      ->Promise.thenResolve(res => {
        switch res->Webapi.Fetch.Response.ok {
        | true => onAddDone()
        | false => Js.Exn.raiseError("Request failed")
        }
      })
      ->Promise.catch(e => {
        action(SetError)
        Promise.reject(e)
      })
      ->Fetch
      ->action
    | None => action(SetError)
    }
  }

  switch state {
  | Idle =>
    <form
      ref={ReactDOM.Ref.domRef(formEl)}
      className="w-full my-4 flex flex-col justify-center items-center gap-2"
      onSubmit>
      <label className="block w-full">
        <span className="inline-block w-1/3 text-right"> {React.string(`단어`)} </span>
        <input
          name="name"
          required=true
          type_="text"
          className="mx-4 w-1/2 rounded border border-gray-400"
        />
      </label>
      <label>
        <span className="inline-block w-1/3 text-right"> {React.string(`이미지 파일`)} </span>
        <input name="image" required=true type_="file" className="mx-4 w-1/2" />
      </label>
      <label>
        <span className="inline-block w-1/3 text-right"> {React.string(`녹음 파일`)} </span>
        <input name="audio" required=true type_="file" className="mx-4 w-1/2" />
      </label>
      <label className="block w-full">
        <span className="inline-block w-1/3 text-right"> {React.string(`비밀 토큰`)} </span>
        <input
          ref={ReactDOM.Ref.domRef(tokenEl)}
          required=true
          type_="password"
          className="mx-4 w-1/2 rounded border border-gray-400"
        />
      </label>
      <button
        type_="submit" className="rounded-lg my-4 px-6 py-2 text-lg bg-gray-200 hover:bg-gray-300">
        {React.string(`업로드`)}
      </button>
    </form>
  | Fetching =>
    <div className="w-full my-4 flex flex-col justify-center items-center gap-2">
      <div className="text-center">
        <div className="text-gray-600"> {React.string(`업로드 중...`)} </div>
        <div className="text-gray-600"> {React.string(`잠시만 기다려주세요.`)} </div>
      </div>
    </div>
  | FetchError =>
    <div className="w-full my-4 flex flex-col justify-center items-center gap-2">
      <div className="text-center">
        <div className="text-gray-600"> {React.string(`업로드에 실패했습니다.`)} </div>
        <button
          type_="button"
          className="rounded-lg my-4 px-6 py-2 text-lg bg-gray-200 hover:bg-gray-300"
          onClick={_ => action(ResetError)}>
          {React.string(`확인`)}
        </button>
      </div>
    </div>
  }
}
