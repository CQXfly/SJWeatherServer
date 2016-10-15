//
//  RequestHandler.swift
//  SJWeatherServer
//
//  Created by king on 16/10/6.
//
//

import Vapor
import HTTP


let mobWeatherAppKey = "177759da6d40e"
let mobWeatherAppSecret = "37d499112ecb408b1c4007622267cd09"

class RequestHandler {

    
}

// 注册 登录
extension RequestHandler {
    
    static func handlerRegistered(request: Request) throws -> ResponseRepresentable {
        
        guard let userName = request.data["userName"]?.string, let pwd = request.data["pwd"]?.string else {
            return try Response(status: .ok, json: JSON(node: ["error" : "请求参数不正确"]))
        }
        
        let result = DBManager.share().signUpAccount(userName: userName, pwd: pwd)
        
        if result.isOK {
            return try Response(status: .ok, json: JSON(node: ["result" : "注册成功"]))
        } else {
            return try Response(status: .ok, json: JSON(node: ["error" : result.erroInfo]))
        }
    }
    
    static func handlerLogin(request: Request) throws -> ResponseRepresentable {
        
        guard let userName = request.data["userName"]?.string, let pwd = request.data["pwd"]?.string else {
            return try Response(status: .ok, json: JSON(node: ["error" : "请求参数不正确"]))
        }
        
        let result = DBManager.share().sigInAccount(userName: userName, pwd: pwd)
        
        if result.isOK {
            
            return try Response(status: .ok, json: JSON(node: [
                "msg" : "登录成功",
                "result" : Node.object( [
                    "token" : Node.string(result.token)
                    ])
                ]))
        } else {
            return try Response(status: .ok, json: JSON(node: ["error" : result.errorInfo]))
        }
        
    }
    
    static func handlerLogout(request: Request) throws -> ResponseRepresentable {
        guard let token = request.data["token"]?.string else {
            
            return try Response(status: .ok, json: JSON(node: ["error" : "请先登录"]))
        }
        
        let reults = DBManager.share().signOutAccount(token: token)
        if reults.isOk {
            return try Response(status: .ok, json: JSON(node: ["reults" : "已退出"]))
        } else {
            return try Response(status: .ok, json: JSON(node: ["error" : reults.errorInfo]))
        }
    }
    
}

extension RequestHandler {
    
    static func handlerGetCityList(request: Request) throws -> ResponseRepresentable {
        
        guard let token = request.data["token"]?.string , token != "" else {
            
            return try Response(status: .ok, json: JSON(node: ["error" : "请先登录"]))
        }
        
        if DBManager.share().checkTokenExpired(token: token) {
            return try Response(status: .ok, json: JSON(node: ["error" : "授权已过期!"]))
        }
        return try app.client.get(GlobalConfiguration.getCityListURL(), query: ["key" : mobWeatherAppKey])
    }
    
    static func handlerQuery(request: Request) throws -> ResponseRepresentable {
        
        guard let token = request.data["token"]?.string , token != "" else {
            
            return try Response(status: .ok, json: JSON(node: ["error" : "请先登录"]))
        }
        
        if DBManager.share().checkTokenExpired(token: token) {
            return try Response(status: .ok, json: JSON(node: ["error" : "授权已过期!"]))
        }

        
        var parameter: [String : String] = [:]
        
        parameter["key"]  = mobWeatherAppKey
        // 提取城市
        if let city = request.data["city"]?.string {
            
            parameter["city"] = city
            
        } else {
            return try Response(status: .ok, json: JSON(node: ["error" : "请输入要查询的城市"]))
        }
        // 提取省份
        if let province = request.data["province"]?.string {
            parameter["province"] = province
        }
        
        if parameter.isEmpty == false, parameter.count >= 2 {
            print("获取城市数据天气数据.... \(parameter)")
            return try app.client.get(GlobalConfiguration.getQueryURL(),
                                      query: parameter)
        } else {
            return try Response(status: .ok, json: JSON(node: ["error" : "参数不对!"]))
        }
        
    }
    
    static func handlerWeatherType(request: Request) throws -> ResponseRepresentable {
        
        guard let token = request.data["token"]?.string , token != "" else {
            
            return try Response(status: .ok, json: JSON(node: ["error" : "请先登录"]))
        }
        
        if DBManager.share().checkTokenExpired(token: token) {
            return try Response(status: .ok, json: JSON(node: ["error" : "授权已过期!"]))
        }

        
        return try app.client.get(GlobalConfiguration.getWeatherTypeURL(), query: ["key" : mobWeatherAppKey])
    }
}
