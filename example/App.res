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

app->useWithError((err, _req, res, _next) => {
  Js.Console.error(err)
  open Res
  let _ = res->status(500)->endWithData("An error occured")
})

let _ = app->listen(8081)
