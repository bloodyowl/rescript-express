open Express

let app = expressCjs()

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
