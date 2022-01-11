//
//  TaskModel.swift
//  BucketcURD
//
//  Created by administrator on 11/01/2022.
//

import Foundation
class TaskModel {
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        let url = URL(string: "http://127.0.0.1:8080/tasks")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
    }
}


