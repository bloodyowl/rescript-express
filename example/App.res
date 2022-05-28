open Express

let app = expressCjs()

let router = Router.make()

router->Router.use((req, _res, next) => {
  Js.log(req)
  next()
})

router->Router.useWithError((err, _req, res, _next) => {
  Js.Console.error(err)
  let _ = res->status(500)->endWithData("An error occured")
})

app->useRouterWithPath("/someRoute", router)

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

app->all("/allRoute", (_req, res) => {
  res->status(200)->json({"ok": true})->ignore
})

app->useWithError((err, _req, res, _next) => {
  Js.Console.error(err)
  let _ = res->status(500)->endWithData("An error occured")
})

app->get("/stream", (req, res) => {
  res->set("Cache-Control", "no-cache")
  res->set("Content-Type", "text/event-stream")
  res->set("Connection", "keep-alive")
  req->flushHeaders->ignore

  res->onClose(() => {
    Js.Console.log("Stream Ended")
  })

  res->write(`data: Hello World`)->ignore
  res->write(`data: Hello World`)->ignore
  res->end->ignore
})

let port = 8081
let _ = app->listenWithCallback(port, _ => {
  Js.Console.log(`Listening on http://localhost:${port->Belt.Int.toString}`)
})
