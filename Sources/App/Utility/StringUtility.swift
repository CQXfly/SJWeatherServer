//
//  StringUtility.swift
//  SJWeatherServer
//
//  Created by king on 16/10/7.
//
//
import Foundation
import Vapor
import Hash

class StringUtility {
    
    static func isEmpty(_ param: String?) -> Bool {
        if let string = param {
            return string.isEmpty
        } else {
            return true
        }
    }
    
    static func convertToString(param: Float) -> String {
        return String(stringInterpolationSegment: param)
    }
    
    static func convertToString(param: Double) -> String {
        return String(stringInterpolationSegment: param)
    }
    
    static func convertToString(param: Int) -> String {
        return String(param)
    }
    
    static func generateSignInToken(userID: Int) -> String {
        let timestamp = Date().timeIntervalSince1970
        let tokenFormat = "\(userID)" + "_" + "\(timestamp)"
        do {
            let byes = try tokenFormat.makeBytes()
            let result = try Hash.make(.sha512, byes)
            print("Hash: \(result.base64String)")
            return result.base64String
        } catch let error {
            print(error)
        }
        
        return ""
    }
    
  
}
