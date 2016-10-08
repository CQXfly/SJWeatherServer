import Vapor

let app = Droplet()

app.group("/v1") { api in
    
    api.get("registered.json") { request in
        
        return try RequestHandler.handlerRegistered(request: request)
    }
    
    api.get("login.json") { request in
        
        return try RequestHandler.handlerLogin(request: request)
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

app.run()
