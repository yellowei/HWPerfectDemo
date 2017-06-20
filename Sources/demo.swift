////
////  main.swift
////  PerfectTemplate
////
////  Created by Kyle Jessup on 2015-11-05.
////	Copyright (C) 2015 PerfectlySoft, Inc.
////
////===----------------------------------------------------------------------===//
////
//// This source file is part of the Perfect.org open source project
////
//// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
//// Licensed under Apache License v2.0
////
//// See http://perfect.org/licensing.html for license information
////
////===----------------------------------------------------------------------===//
////
//
//import PerfectLib
//import PerfectHTTP
//import PerfectHTTPServer
//
//let server = HTTPServer()
//
//server.serverPort = 8080
//server.serverName = "localhost"
//server.documentRoot = "/Users/yellowei/Documents/GitHub/HWPerfectDemo/webroot"
//
//
//var routes = Routes()
//
////MARK: - 路由配置
//
////MARK: 静态路由
//routes.add(method: .get, uri: "/login") { (request, response) in
//    // Respond with a simple message.
//    response.setHeader(.contentType, value: "text/html")
//    response.appendBody(string: "<html><title>Hello, Login!</title><body>Hello, Login!</body></html>")
//    // Ensure that response.completed() is called when your processing is done.
//    response.completed()
//}
//
//routes.add(method: .get, uri: "/hello") { (request, response) in
//    // Respond with a simple message.
//    response.setHeader(.contentType, value: "text/html")
//    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
//    // Ensure that response.completed() is called when your processing is done.
//    response.completed()
//}
//
//
//routes.add(method: .get, uri: "/hello") { (request, response) in
//    // Respond with a simple message.
//    response.setHeader(.contentType, value: "text/html")
//    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
//    // Ensure that response.completed() is called when your processing is done.
//    response.completed()
//}
// 
////MARK: 动态路由
//let valueKey = "key"
//routes.add(method: .get, uri: "/path1/{\(valueKey)}") { (request, response) in
//    // Respond with a simple message.
//    response.setHeader(.contentType, value: "text/html")
//    response.appendBody(string: "该路由中的路由变量为: \(String(describing: request.urlVariables[valueKey]))")
//    // Ensure that response.completed() is called when your processing is done.
//    response.completed()
//}
//
////MARK: 路由通配符
//routes.add(method: .get, uri: "/path2/*/detail") { (request, response) in
//    response.appendBody(string: "通配符路由: \(request.path)")
//    response.completed()
//}
//
////MARK: 结尾通配符
//routes.add(method: .get, uri: "/path3/**") { (request, response) in
//    response.appendBody(string: "\(String(describing: request.urlVariables[routeTrailingWildcardKey]))")
//    response.completed()
//}
//
////MARK: 设置路由并启动server
//server.addRoutes(routes)
//
//
//
////MARK: - 表单提交与Json返回
//let server_1 = HTTPServer()
//
//server_1.serverPort = 8181
//server_1.serverName = "localhost"
//server_1.serverAddress = "127.0.0.1"
//server_1.documentRoot = "/Users/yellowei/Documents/GitHub/HWPerfectDemo/webroot"
//
//var routes_1 = Routes()
//
////MARK: 构建form表单
///*
// <html>
// <head>
// <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
// <title>登录</title>
// </head>
// <body>
// <h1>登录</h1>
// <form action = "http://127.0.0.1/login" method = "POST">
// 用户名： <input type="text" name="userName"/><br/>
// 密&nbsp;&nbsp;&nbsp;码: <input type="password" name="password"/><br/>
// <input type="submit" value="提交"/>
// </form>
// </body>
// </html>
//
// */
//routes_1.add(method: .post, uri: "/login") { (request, response) in
////    response.appendBody(string: "\(request.)")
//}
//
////MARK: 获取form表单参数
//
//
////MARK: 设置路由并启动server
//server_1.addRoutes(routes_1)
//
//
////MARK: - 启动服务器
//do{
//    try HTTPServer.launch(configurationData: ["":""])
//}catch{
//    fatalError("\(error)")
//}
//
//
//
