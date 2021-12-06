module Promise = Js.Promise

type t<'t> = ('t => unit) => unit
let make = (f: ('t => unit) => unit) => f
let run = (t, resolve) => t(resolve)
let map = (t, fn) => make(resolve => t->run(x => x->fn->resolve))
let flatMap = (t, fn) => make(resolve => t->run(x => x->fn->run(resolve)))
let unit = a => make(resolve => a->resolve)

let join = t => t->flatMap(a => a)

let toPromise = t =>
  Promise.make((~resolve, ~reject) => {
    t->run(body => {
      reject->ignore

      resolve(. body)
    })
  })

let fromPromise = (fn, ~resolve, ~reject) => {
  make(res => {
    fn()->Promise.then_(body => {
      body->resolve->res
      Promise.resolve()
    }, _)->Promise.catch(err => {
      err->reject->res
      Promise.resolve()
    }, _)->ignore
  })
}

module Cancellable = {
  type cancel = unit => unit

  let run = (t, fn) => {
    let shouldRun = ref(true)

    t->run(x => {
      if shouldRun.contents {
        fn(x)
      }
    })

    () => shouldRun.contents = false
  }
}
