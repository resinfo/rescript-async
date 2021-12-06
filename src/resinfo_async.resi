type t<'t>

let make: (('t => unit) => unit) => t<'t>
let unit: 'a => t<'a>

let map: (t<'t>, 't => 'r) => t<'r>
let flatMap: (t<'t>, 't => t<'r>) => t<'r>

let run: (t<'t>, 't => unit) => unit

let join: t<t<'t>> => t<'t>

let toPromise: t<'a> => Js.Promise.t<'a>
let fromPromise: (
  unit => Js.Promise.t<'a>,
  ~resolve: 'a => 'b,
  ~reject: Js.Promise.error => 'b,
) => t<'b>

module Cancellable: {
  type cancel = unit => unit

  let run: (t<'a>, 'a => unit) => cancel
}
