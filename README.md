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

## Module system

For now, due to compability issues between commonJS and ES6 module, the bindings expose two `express` functions:

- `express` for ES6
- `expressCjs` to CommonJS

Be careful to pick the right one given your compiler's configuration.

## API

The API closely matches the express one. You can refer to the [express docs](https://expressjs.com/en/4x/api.html).

### Notable differences

- `express.json`, `express.raw`, `express.text`, `express.urlencoded`, `express.static` are all suffixed with `Middleware` to prevent name clashing.
- `accept*` and `is` return an option intead of a string/boolean
- `req.get` is called `getRequestHeader` and `res.get` is called `getResponseHeader`

You can check [the interface file](./src/Express.resi) to see the exposed APIs.

## Example

```rescript
open Express

let app = express()

app->use(jsonMiddleware())

app->get("/", (_req, res) => {
  let _ = res->status(200)->json({"ok": true})
})

app->post("/ping", (req, res) => {
  let body = req->body
  let _ = switch body["name"]->Js.Nullable.toOption {
  | Some(name) => res->status(200)->json({"message": `Hello ${name}`})
  | None => res->status(400)->json({"error": `Missing name`})
  }
})

app->useWithError((err, _req, res, _next) => {
  Js.Console.error(err)
  let _ = res->status(500)->endWithData("An error occured")
})

let port = 8081
let _ = app->listenWithCallback(port, _ => {
  Js.Console.log(`Listening on http://localhost:${port->Belt.Int.toString}`)
})
```

Generates the following

```js
var Express = require("express");

var app = Express();

app.use(Express.json());

app.get("/", function (_req, res) {
  res.status(200).json({
    ok: true,
  });
});

app.post("/ping", function (req, res) {
  var body = req.body;
  var name = body.name;
  if (name == null) {
    res.status(400).json({
      error: "Missing name",
    });
  } else {
    res.status(200).json({
      message: "Hello " + name,
    });
  }
});

app.use(function (err, _req, res, _next) {
  console.error(err);
  res.status(500).end("An error occured");
});

app.listen(8081, function (param) {
  console.log("Listening on http://localhost:" + String(8081));
});
```
