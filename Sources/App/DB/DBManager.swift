//
//  DBManager.swift
//  SJWeatherServer
//
//  Created by king on 16/10/7.
//
//

import Foundation
import MySQL

class DBManager {
    
    private static var instance: DBManager!
    private var databaseConnectionStatus = false
    @discardableResult
    static func share() -> DBManager {
        
        if instance == nil {
            instance = DBManager()
        }
        return instance
    }
    
    private var mysql: MySQL.Database!
    
    init() {
        setUp()
    }
    
    private func setUp() {
        
        do {
            mysql = try MySQL.Database(
                host: DBConfig.HOST,
                user: DBConfig.USER,
                password: DBConfig.PWD,
                database: DBConfig.DATABASE,
                port: 3306
            )
            print("MySQL connect success")
            databaseConnectionStatus = true
        } catch {
            print("MySQL connect failed")
            databaseConnectionStatus = false
        }
    }
    
    @discardableResult
    func signUpAccount(userName: String, pwd: String) -> (isOK: Bool, erroInfo: String) {
        
        guard databaseConnectionStatus else {
            
            return (false, "数据库连接失败!")
        }
        
        do {
            var results = try mysql.execute("select user_id from user where name=\"\(userName)\";")
            if results.count > 0 {
                
                if let userid = results[0]["user_id"] {
                    
                    if case let .number(.int(userid)) = userid {
                        
                        print(userid)
                        return (false, "该用户名已被注册,请换个用户名")
                    }
                }
            } else {
                
                results = try mysql.execute("insert into user (name, pwd) values(\"\(userName)\",\"\(pwd)\");")
                
                return (true, "")
            }
            
           
        } catch let error {
            
            print(error)
        }
        return (false, "")
    }
    func signOutAccount(token: String) -> (isOk: Bool, errorInfo: String) {
        
        guard databaseConnectionStatus else {
            
            return (false, "数据库连接失败!")
        }
        
        do {
            var results = try mysql.execute("delete from sign_in where token=\"\(token)\";")
            results = try mysql.execute("select * from sign_in where token=\"\(token)\";")
            if results.count == 0 {
                return (true, "")
            } else {
                return (false, "未知错误")
            }
        } catch  {
            
        }
        
        return (false, "未知错误")
    }
    func queryUserId(userName: String, pwd: String) -> (userId: Int, erroInfo: String) {
        
        guard databaseConnectionStatus else {
            
            return (0, "数据库连接失败!")
        }
        
        do {
            var results = try mysql.execute("select user_id from user where name=\"\(userName)\" and pwd=\"\(pwd)\";")
            
            if results.count > 0 {
            
                if let userid = results[0]["user_id"] {
                    
                    if case let .number(.int(userid)) = userid {
                        return (userid, "")
                    }
                }
            } else {
                
                return (0, "账号或者密码错误!")
            }
        } catch  {
            
        }
        return (0, "账号或者密码错误!")
    }
    
    @discardableResult
    func sigInAccount(userName: String, pwd: String) -> (isOK: Bool, token: String, errorInfo: String) {
        
        guard databaseConnectionStatus else {
            
            return (false, "", "数据库连接失败!")
        }
        let userid = queryUserId(userName: userName, pwd: pwd)
        
        if userid.erroInfo != "" {
            
            return (false, "", userid.erroInfo)
        }
        
        do {
            
            var results = try mysql.execute("select token from sign_in where user_id=\(userid.userId);")
            
            if results.count > 0 {
                
                if let token = results[0]["token"] {
                    
                    if case let .string(token) = token {
                        return (true, token, "")
                    }
                }
            } else {
            
                let token = StringUtility.generateSignInToken(userID: userid.userId)
                if token == "" {
                    return (false, "", "获取Token失败!!,请重试!")
                }
                let create_time = Date().timeIntervalSince1970
                
                results = try mysql.execute("insert into sign_in (user_id, token, create_time) values(\(userid.userId),\"\(token)\",\(create_time));")
                
                results = try mysql.execute("select token from sign_in where user_id=\(userid.userId);")
                
                if results.count > 0 {
                    return (true, token, "")
                } else {
                    return (false, "", "获取Token失败!!,请重试!")
                }
            }
        } catch {
            
        }
        
        return (false, "", "获取Token失败!!,请重试!")
    }
    
    @discardableResult
    func checkTokenExpired(token: String) -> Bool {
        
        let expired: Double = 60.0 * 60.0 * 24.0 * 10.0
        
        do {
            print(token)
            let results = try mysql.execute("select create_time from sign_in where token=\"\(token)\";")
            print(results)
//            if let create_time = results[0]["create_time"] {
//                
//                if case let .number(.double(create_time)) = create_time {
//                    print("create_time: \(create_time)")
//                    if create_time + expired < Date().timeIntervalSince1970   {
//                       return true
//                    }
//                }
//            }
        } catch {
            
        }
        
        return false
    }
}
