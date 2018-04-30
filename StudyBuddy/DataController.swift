//
//  DataController.swift
//  StudyBuddy
//
//  Created by student on 4/30/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import Foundation

struct User: Codable {
    var email: String = ""
    var first_name: String = ""
    var last_name: String = ""
    var password: String = ""
    var username: String = ""
}

struct CramJam: Codable {
    var host: String
    var start_time: String
    var end_time: String
    var subject: String
    var max_peeps: Int
    var description: String
    var location: String
}

struct Location: Codable {
    var name: String
    var lat: Decimal
    var lon: Decimal
}

class DataController {
    static func getData(table: String, condition: String, completion: @escaping (Data?)->()) {
        let id = "21232f297a57a5a743894a0e4a801fc3"
        var urlStr = "http://baruchhaba.org/StudyBuddy/query.php?id=\(id)&type=select&table=\(table)"
        if !condition.isEmpty {
            urlStr += "&condition=\(condition)"
        }
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                completion(data)
            }).resume()
        } else {
            completion("".data(using: .utf8))
        }
    }
    
    static func putData(table: String, values: [String], completion: @escaping (Bool)->()) {
        let id = "21232f297a57a5a743894a0e4a801fc3"
        var urlStr = "http://baruchhaba.org/StudyBuddy/query.php?id=\(id)&type=insert&table=\(table)&values="
        for i in 0 ... values.count - 2 {
            urlStr += "%22\(values[i])%22%2C%20"
        }
        urlStr += "%22\(values[values.count - 1])%22"
        print(urlStr)
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                let dataStr = String(decoding: data!, as: UTF8.self)
                if Int(dataStr) == 1 {
                    completion(true)
                } else {
                    completion(false)
                }
            }).resume()
        } else {
            completion(false)
        }
    }
}
