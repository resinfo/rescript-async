# @resinfo/async

A ReScript module providing a lazy, typesafe API for writing asynchronous code.

## NOTE:

This version currently only works with ES modules, which requires

```json
{
  "type": "module"
}
```

to be set in your `package.json`

## Installation

via NPM.

```bash
yarn add @resinfo/async
# or
npm install --save @resinfo/async
```

## Usage:

```rescript
module Async = Resinfo_async

// Construct from a promise
let fetch = url => {
  Async.fromPromise(
    // assume "get" is a previously defined promise function
    () => get(url),
    ~resolve=json => Ok(json),
    ~reject=_ => Error()
  )
}

// This is a regular value that can be passed around like
// any other; it isn't run until explicitly called
let fetchProfile = {
  fetch("https://api.github.com/users/resinfo")
  ->Async.map(result => {
    switch result {
      | Ok(json) => json.login
      | Error() => "Unable to get user"
    }
  })
}

// Run as callback
fetchProfile->Async.run(name => {
  Js.log2("Name is", name)
})

// Run as promise
fetchProfile
  ->Async.toPromise
  ->Js.Promise.then_(name => {
    Js.log2("Name is", name)

    Js.Promise.resolve()
  }, _)


```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
