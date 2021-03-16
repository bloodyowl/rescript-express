open Express

let app = express()

app->use(jsonMiddleware())

app->get("/", (_req, res) => {
  open Res
  let _ = res->status(200)->json({"ok": true})
})

app->post("/ping", (req, res) => {
  open Req
  // might be fixed later so that we can use
  // req->body["name"]
  // https://github.com/rescript-lang/syntax/issues/203
  let name = (req->body)["name"]
  open Res
  let _ = res->status(200)->json({"message": `Hello ${name}`})
})

let _ = app->listen(8081)
