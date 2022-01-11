//
//  apiB.swift
//  BucketcURD
//
//  Created by administrator on 11/01/2022.
//

import Foundation

class apiB {
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response:URLResponse?, _ error:Error?) -> Void){
        URLSession.shared.dataTask(with: URL(string: "http://127.0.0.1:8080/tasks")!, completionHandler: completionHandler).resume()
    }
    
    static func addTask(objective:String, completionHandler: @escaping(_ data: Data?, _ response:URLResponse?, _ error:Error?) -> Void){
        
        var request = URLRequest(url: URL(string:"http://127.0.0.1:8080/tasks")!)
        request.httpMethod = "POST"
        let bodyData = "objective=\(objective)"
        request.httpBody = bodyData.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
    static func deleteTask(index:Int, completionHandler: @escaping(_ data: Data?, _ response:URLResponse?, _ error:Error?) -> Void){
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/tasks/\(index)")!)
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request,completionHandler: completionHandler).resume()
    }
    
    static func updateTask(index:Int,objective:String,completionHandler: @escaping(_ data: Data?, _ response:URLResponse?, _ error:Error?) -> Void){
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/tasks/\(index)")!)
        request.httpMethod = "PATCH"
        let bodyObj = ["objective": objective]
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyObj)
        }catch{
            print(error)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }
}
