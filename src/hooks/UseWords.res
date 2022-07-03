let error = ref(None)
let words: ref<option<Word.res>> = ref(None)
let lastFetched: ref<option<int>> = ref(None)

let use = () => {
  let fetch = () =>
    Word.getWords()->Promise.thenResolve(res => {
      words := Some(res)
      lastFetched := Some(Js.Date.now()->Belt.Int.fromFloat)
      error := None
      res
    })->Promise.catch(e => {
      error := Some(e)
      raise(e)
    })
  
  let reset = () => {
    words := None
    lastFetched := None
    error := None
  }

  let words = switch (words.contents, lastFetched.contents, error.contents) {
  | (Some(words), Some(lastFetched), None) => {
      if lastFetched < Js.Date.now()->Belt.Int.fromFloat - (60 * 60 * 1000) {
        fetch()->ReactDOM18.throwPromise
      }
      Some(words)
    }
  | (_, _, Some(e)) => {
      raise(e)
    }
  | _ => {
      fetch()->ReactDOM18.throwPromise
      None
    }
  }

  (words, reset)
}
