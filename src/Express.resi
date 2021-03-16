type express

@module("express") external express: unit => express = "default"

type req
type res

type middleware = (req, res, unit => unit) => unit
type handler = (req, res) => unit

external asMiddleware: express => middleware = "%identity"

@module("express") @scope("default") external jsonMiddleware: unit => middleware = "json"
@module("express") @scope("default") external jsonMiddlewareWithOptions: {..} => middleware = "json"
@module("express") @scope("default") external rawMiddleware: unit => middleware = "raw"
@module("express") @scope("default") external rawMiddlewareWithOptions: {..} => middleware = "raw"
@module("express") @scope("default") external textMiddleware: unit => middleware = "text"
@module("express") @scope("default") external textMiddlewareWithOptions: {..} => middleware = "text"
@module("express") @scope("default")
external urlencodedMiddleware: unit => middleware = "urlencoded"
@module("express") @scope("default")
external urlencodedMiddlewareWithOptions: {..} => middleware = "urlencoded"
@module("express") @scope("default") external staticMiddleware: string => middleware = "static"
@module("express") @scope("default")
external staticMiddlewareWithOptions: (string, {..}) => middleware = "static"

@send external use: (express, middleware) => unit = "use"
@send external useWithPath: (express, string, middleware) => unit = "use"

@send external get: (express, string, handler) => unit = "get"
@send external post: (express, string, handler) => unit = "post"
@send external del: (express, string, handler) => unit = "del"
@send external patch: (express, string, handler) => unit = "patch"
@send external put: (express, string, handler) => unit = "put"

@send external enable: (express, string) => unit = "enable"
@send external enabled: (express, string) => bool = "enabled"
@send external disable: (express, string) => unit = "disable"
@send external path: express => string = "path"

type server

@send external listen: (express, int) => server = "listen"
@send
external listenWithCallback: (express, int, (option<Js.Exn.t>, unit) => unit) => server = "listen"
@send
external listenWithHostAndCallback: (
  express,
  ~port: int,
  ~host: string,
  (option<Js.Exn.t>, unit) => unit,
) => server = "listen"

type method = [#GET | #POST | #PUT | #DELETE | #PATCH]

module Req: {
  // req properties
  @get external baseUrl: req => string = "baseUrl"
  @get external body: req => 'a = "body"
  @get external cookies: req => 'a = "cookies"
  @get external fresh: req => bool = "fresh"
  @get external hostname: req => string = "hostname"
  @get external ip: req => string = "ip"
  @get external ips: req => array<string> = "ips"
  @get external method: req => method = "method"
  @get external originalUrl: req => string = "originalUrl"
  @get external params: req => 'a = "params"
  @get external path: req => string = "path"
  @get external protocol: req => string = "protocol"
  @get external query: req => 'a = "query"
  @get external route: req => 'a = "route"
  @get external secure: req => bool = "secure"
  @get external signedCookies: req => 'a = "signedCookies"
  @get external stale: req => bool = "stale"
  @get external subdomains: req => array<string> = "subdomains"
  @get external xhr: req => bool = "xhr"

  // req methods
  let accepts: (req, array<string>) => option<string>
  let acceptsCharset: (req, array<string>) => option<string>
  let acceptsEncodings: (req, array<string>) => option<string>
  let acceptsLanguages: (req, array<string>) => option<string>

  @send external get: (req, string) => option<string> = "get"

  let is: (req, string) => option<string>

  @send external param: (req, string) => option<string> = "param"
}

module Res: {
  // res properties
  @get external headersSent: res => bool = "headersSent"
  @get external locals: res => {..} = "locals"

  // res methods
  @send external append: (res, string, string) => res = "append"
  @send external attachment: (res, ~filename: string=?) => res = "attachment"
  @send external cookie: (res, ~name: string, ~value: string) => res = "cookie"
  @send external cookieWithOptions: (res, ~name: string, ~value: string, {..}) => res = "cookie"
  @send external clearCookie: (res, string) => res = "clearCookie"
  @send external download: (res, ~path: string) => res = "download"
  @send external downloadWithFilename: (res, ~path: string, ~filename: string) => res = "download"
  @send external end: res => res = "end"
  @send external endWithData: (res, 'a) => res = "end"
  @send external endWithDataAndEncoding: (res, 'a, ~encoding: string) => res = "end"
  @send external format: (res, {..}) => res = "format"
  @send external get: (res, string) => option<string> = "get"
  @send external json: (res, 'a) => res = "json"
  @send external jsonp: (res, 'a) => res = "jsonp"
  @send external links: (res, Js.Dict.t<string>) => res = "links"
  @send external location: (res, string) => res = "location"
  @send external redirect: (res, string) => res = "redirect"
  @send external redirectWithStatusCode: (res, ~statusCode: int, string) => res = "redirect"
  @send external send: (res, 'a) => res = "send"
  @send external sendFile: (res, string) => res = "sendFile"
  @send external sendFileWithOptions: (res, string, {..}) => res = "sendFile"
  @send external sendStatus: (res, int) => res = "sendStatus"
  @send external set: (res, string, string) => unit = "set"
  @send external status: (res, int) => res = "status"
  @send external \"type": (res, string) => string = "type"
  @send external vary: (res, string) => res = "vary"
}
