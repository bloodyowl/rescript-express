# rescript-express

> (nearly) zero-cost bindings to express 

## Installation

Run the following in your console:

```console
$ yarn add rescript-express express
```

Then add `rescript-express` to your `bsconfig.json`'s `bs-dependencies`:

```diff
 {
   "bs-dependencies": [
+    "rescript-express"
   ]
 }
```

## API

The API closely matches the express one. You can refer to the [express docs](https://expressjs.com/en/4x/api.html).

### Notable differences

- `Router` isn't implemented
- `express.json`, `express.raw`, `express.text`, `express.urlencoded`, `express.static` are all suffixed with `Middleware` to prevent name clashing.
- `accept*` and `is` return an option intead of a string/boolean

You can check [the interface file](./src/Express.resi) to see the exposed APIs.

## Example

```rescript
open Express

let app = express()

app->use(jsonMiddleware())

app->get("/", (_req, res) => {
  open Res
  let _ = res->status(200)->json({"ok": true})
})

app->post("/ping", (req, res) => {
  open Req
  let body = req->body
  open Res
  let _ = switch body["name"]->Js.Nullable.toOption {
  | Some(name) => res->status(200)->json({"message": `Hello ${name}`})
  | None => res->status(400)->json({"error": `Missing name`})
  }
})
````