//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

let server = HTTPServer()

server.serverPort = 8080
server.serverName = "localhost"
server.documentRoot = "/Users/yellowei/Documents/PerfectTemplate-master/webroot"


var routes = Routes()


//MARK: -静态路由
routes.add(method: .get, uri: "/login") { (request, response) in
    // Respond with a simple message.
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>Hello, Login!</title><body>Hello, Login!</body></html>")
    // Ensure that response.completed() is called when your processing is done.
    response.completed()
}

routes.add(method: .get, uri: "/hello") { (request, response) in
    // Respond with a simple message.
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
    // Ensure that response.completed() is called when your processing is done.
    response.completed()
}


routes.add(method: .get, uri: "/hello") { (request, response) in
    // Respond with a simple message.
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
    // Ensure that response.completed() is called when your processing is done.
    response.completed()
}
 
//MARK: - 动态路由
let valueKey = "key"
routes.add(method: .get, uri: "/path1/{\(valueKey)}") { (request, response) in
    // Respond with a simple message.
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "该路由中的路由变量为: \(String(describing: request.urlVariables[valueKey]))")
    // Ensure that response.completed() is called when your processing is done.
    response.completed()
}

//MARK: - 路由通配符
routes.add(method: .get, uri: "/path2/*/detail") { (request, response) in
    response.appendBody(string: "通配符路由: \(request.path)")
    response.completed()
}

//MARK: -结尾通配符
routes.add(method: .get, uri: "/path3/**") { (request, response) in
    response.appendBody(string: "\(String(describing: request.urlVariables[routeTrailingWildcardKey]))")
    response.completed()
}




//MARK: - 设置路由并启动server
server.addRoutes(routes)

do{
    try server.start()
}catch{
    fatalError("\(error)")
}

