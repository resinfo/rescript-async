## API:

```rescript
type t<'a>
```

```rescript
let make: (('a => unit) => unit) => t<'a>
```

```rescript
let fromPromise: (
  unit => Js.Promise.t<'a>,
  ~resolve: 'a => 'b,
  ~reject: Js.Promise.error => 'b,
) => t<'b>
```

```rescript
let unit: 'a => t<'a>
```

```rescript
let map: (t<'a>, 'a => 'r) => t<'r>
```

```rescript
let flatMap: (t<'a>, 'a => t<'r>) => t<'r>
```

```rescript
let run: (t<'a>, 'a => unit) => unit
```

```rescript
let join: t<t<'a>> => t<'a>
```

```rescript
let toPromise: t<'a> => Js.Promise.t<'a>
```

```rescript
module Cancellable: {
  type cancel = unit => unit

  let run: (t<'a>, 'a => unit) => cancel
}
```
