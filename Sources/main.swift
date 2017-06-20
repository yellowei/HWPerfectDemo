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
import PerfectMustache

//MARK: - request handler.
// This 'handler' function can be referenced directly in the configuration below.


/// 一般处理句柄
///
/// - Parameter data: 路由参数
/// - Returns: 处理请求的回调闭包
/// - Throws: 异常处理
func normalHandler(data: [String:Any]) throws -> RequestHandler {
    
    guard let uri = data["uri"] as? String else {
        return try errorHandler(data: data)
    }
    
    switch uri {
        
    case "/login":
        return try loginHandler(data: data)
    case "/":
        return try mustacheHandler(data: data)
    default:
        return try errorHandler(data: data)
        
    }
}

/// 错误处理句柄
///
/// - Parameter data: 路由参数
/// - Returns: 处理请求的回调闭包
/// - Throws: 异常处理
func errorHandler(data: [String: Any]) throws -> RequestHandler {
    
    return {(request, response)->() in
        response.appendBody(string: "请求处理错误")
        response.completed()
    }
}

/// 登录处理句柄
///
/// - Parameter data: 路由参数
/// - Returns: 处理请求的回调闭包
/// - Throws: 异常处理
func loginHandler(data: [String:Any]) throws -> RequestHandler {
    return { request, response in
        // Respond with a simple message.
        guard let userName = request.param(name: "userName") else {
            return
        }
        
        guard let password = request.param(name: "password") else {
            return
        }
        
        let responsDic: [String : Any] = ["response":["userName":userName,
                                                      "password":password],
                                          "result":"SUCCESS",
                                          "resultMessage":"请求成功"]
        
        do{
            let json = try responsDic.jsonEncodedString()
            response.setBody(string: json)
            
        }catch{
            response.setBody(string: "json转换错误")
        }
        
        response.completed()
    }
}



func mustacheHandler(data: [String: Any]) throws -> RequestHandler {
    
    return {(request, response)->() in
        
        let webRoot = request.documentRoot
        mustacheRequest(request: request, response: response, handler: BaseHandler(), templatePath: webRoot + "/index.html")
    }
}



//MARK: - Configuration data for two servers.
// This configuration shows how to launch one or more servers
// using a configuration dictionary.

let port1 = 8080, port2 = 8181

HTTPServer().documentRoot = "/Users/yellowei/Documents/MyPods/HWPerfectDemo/webroot"

let confData = [
    "servers": [
        // Configuration data for one server which:
        //	* Serves the hello world message at <host>:<port>/
        //	* Serves static files out of the "./webroot"
        //		directory (which must be located in the current working directory).
        //	* Performs content compression on outgoing data when appropriate.
        [
            "name":"localhost",
            "port":port1,
            "routes":[
                ["method":"get", "uri":"/", "handler":normalHandler,
                 "documentRoot":"/Users/yellowei/Documents/MyPods/HWPerfectDemo/webroot",
                 "allowResponseFilters":true],
                ["method":"post", "uri":"/login", "handler":normalHandler]
            ],
            "filters":[
                [
                    "type":"response",
                    "priority":"high",
                    "name":PerfectHTTPServer.HTTPFilter.contentCompression,
                    ]
            ]
        ],
        // Configuration data for another server which:
        //	* Redirects all traffic back to the first server.
        [
            "name":"localhost",
            "port":port2,
            "routes":[
                ["method":"get", "uri":"/**", "handler":PerfectHTTPServer.HTTPHandler.redirect,
                 "base":"http://localhost:\(port1)"]
            ]
        ]
    ]
]


do {
    // Launch the servers based on the configuration data.
    try HTTPServer.launch(configurationData: confData)
} catch {
    fatalError("\(error)") // fatal error launching one of the servers
}

