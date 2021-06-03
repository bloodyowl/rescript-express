type express

// "default" &  seem to conflict a bit right now
// https://github.com/rescript-lang/rescript-compiler/issues/5004
@module external expressCjs: unit => express = "express"
@module("express") external express: unit => express = "default"

type req
type res

type middleware = (req, res, unit => unit) => unit
type middlewareWithError = (Js.Exn.t, req, res, unit => unit) => unit
type handler = (req, res) => unit

external asMiddleware: express => middleware = "%identity"

// The *Middleware suffixes aren't really nice but avoids forcing people to disable warning 44
@module("express") external jsonMiddleware: unit => middleware = "json"
@module("express") external jsonMiddlewareWithOptions: {..} => middleware = "json"
@module("express") external rawMiddleware: unit => middleware = "raw"
@module("express") external rawMiddlewareWithOptions: {..} => middleware = "raw"
@module("express") external textMiddleware: unit => middleware = "text"
@module("express") external textMiddlewareWithOptions: {..} => middleware = "text"
@module("express")
external urlencodedMiddleware: unit => middleware = "urlencoded"
@module("express")
external urlencodedMiddlewareWithOptions: {..} => middleware = "urlencoded"
@module("express") external staticMiddleware: string => middleware = "static"
@module("express")
external staticMiddlewareWithOptions: (string, {..}) => middleware = "static"

@send external use: (express, middleware) => unit = "use"
@send external useWithPath: (express, string, middleware) => unit = "use"

@send external useWithError: (express, middlewareWithError) => unit = "use"
@send external useWithPathAndError: (express, string, middlewareWithError) => unit = "use"

@send external get: (express, string, handler) => unit = "get"
@send external post: (express, string, handler) => unit = "post"
@send external delete: (express, string, handler) => unit = "delete"
@deprecated("Express 5.0 deprecates app.del(), use app.delete() instead")
@send external del: (express, string, handler) => unit = "del"
@send external patch: (express, string, handler) => unit = "patch"
@send external put: (express, string, handler) => unit = "put"
@send external all: (express, string, handler) => unit = "all"

@send external enable: (express, string) => unit = "enable"
@send external enabled: (express, string) => bool = "enabled"
@send external disable: (express, string) => unit = "disable"

type server

@send external listen: (express, int) => server = "listen"
@send
external listenWithCallback: (express, int, option<Js.Exn.t> => unit) => server = "listen"
@send
external listenWithHostAndCallback: (
  express,
  ~port: int,
  ~host: string,
  option<Js.Exn.t> => unit,
) => server = "listen"

type method = [#GET | #POST | #PUT | #DELETE | #PATCH]

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

let accepts: (req, array<string>) => option<string>
let acceptsCharset: (req, array<string>) => option<string>
let acceptsEncodings: (req, array<string>) => option<string>
let acceptsLanguages: (req, array<string>) => option<string>

@send external getRequestHeader: (req, string) => option<string> = "get"

let is: (req, string) => option<string>

@send external param: (req, string) => option<string> = "param"

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
@send external getResponseHeader: (res, string) => option<string> = "get"
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

module Router: {
  type t
  @module("express") external make: () => t = "Router"
  @send external use: (t, middleware) => unit = "use"
  @send external useWithPath: (t, string, middleware) => unit = "use"

  @send external useWithError: (t, middlewareWithError) => unit = "use"
  @send external useWithPathAndError: (t, string, middlewareWithError) => unit = "use"

  @send external get: (t, string, handler) => unit = "get"
  @send external post: (t, string, handler) => unit = "post"
  @send external delete: (t, string, handler) => unit = "delete"
  @deprecated("Express 5.0 deprecates app.del(), use app.delete() instead")
  @send external del: (t, string, handler) => unit = "del"
  @send external patch: (t, string, handler) => unit = "patch"
  @send external put: (t, string, handler) => unit = "put"
  @send external all: (t, string, handler) => unit = "all"

  type paramHandler = (req, res, unit => unit, string, string) => unit

  @send external param: (t, string, paramHandler) => unit = "param"
  @deprecated("deprecated as of v4.11.0")
  @send external defineParamBehavior: ((string, 'a) => paramHandler) => unit = "param"

  @send external route: string => t = "route"
}

@send external useRouter: (express, Router.t) => unit = "use"
@send external useRouterWithPath: (express, string, Router.t) => unit = "use"
