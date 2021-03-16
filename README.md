# rescript-express

> Work in progress

## Goals

- Be as familiar as possible to people used to express
- Bring no overhead

## Questions for later

- Should we parametrize `req` & `res`?

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
  let name = (req->body)["name"]
  open Res
  let _ = res->status(200)->json({"message": `Hello ${name}`})
})

let _ = app->listen(8081)
````