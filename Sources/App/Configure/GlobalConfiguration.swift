//
//  GlobalConfiguration.swift
//  SJWeatherServer
//
//  Created by king on 16/10/6.
//
//


let mobApiBaseURL = "http://apicloud.mob.com/"

class GlobalConfiguration {
    
    
    private static let CityList = mobApiBaseURL + "v1/weather/citys"
    private static let Query = mobApiBaseURL + "v1/weather/query"
    private static let WeatherType = mobApiBaseURL + "v1/weather/type"
    
    static func getCityListURL() -> String {
        
        return CityList
    }
    
    static func getQueryURL() -> String {
        
        return Query
    }
    
    static func getWeatherTypeURL() -> String {
        
        return WeatherType
    }
}

