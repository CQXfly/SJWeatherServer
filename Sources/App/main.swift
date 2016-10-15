import Vapor
import HTTP

let app = Droplet()

app.group("/v1") { api in
    
    api.get("registered.json") { request in
        
        return try RequestHandler.handlerRegistered(request: request)
    }
    
    api.get("login.json") { request in
        
        return try RequestHandler.handlerLogin(request: request)
    }
    
    api.get("logout.json") { request in
        
        return try RequestHandler.handlerLogout(request: request)
    }
    
    api.get("cityList.json") { request in
        
        return try RequestHandler.handlerGetCityList(request: request)
    }
    
    api.get("query.json") { request in
        
        return try RequestHandler.handlerQuery(request: request)
    }
    
    api.get("type.json") { request in
        
        return try RequestHandler.handlerWeatherType(request: request)
    }
}

app.get("/") { request in
    
    
    let path = app.workDir + "QQ20160816-0.png"
    print(path)
    do {
        let bytes = try DataFile().load(path: "path")
        print(bytes)
        return Response(status: .ok, headers: ["Content-Type" : "image/*"], body: Body.data(bytes))
    } catch {
        
    }
    return try Response(status: .badRequest, json: JSON(node: ["error" : "请求错误"]))
}

app.run()
