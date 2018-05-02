//
//  DataController.swift
//  StudyBuddy
//
//  Created by student on 4/30/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

// holds a row in the user table, converted from JSON
struct User: Codable {
    var email: String = ""
    var first_name: String = ""
    var last_name: String = ""
    var password: String = ""
    var username: String = ""
}

// holds a row in the cram_jam table, converted from JSON
struct CramJam: Codable {
    var id: Int
    var host: String
    var start_time: String
    var end_time: String
    var subject: String
    var max_peeps: Int
    var description: String
    var location: String
}

// holds a row in the location table, converted from JSON
struct Location: Codable {
    var name: String = ""
    var lat: Decimal = 0.0
    var lon: Decimal = 0.0
}

// takes a location and makes it into an annotation able to me plotted on the map
class LocationAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let title: String?
    
    init(location: Location) {
        self.title = location.name
        self.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees((location.lat as NSDecimalNumber).doubleValue), longitude: CLLocationDegrees((location.lon as NSDecimalNumber).doubleValue))
        super.init()
    }
}

// class with static functions for getting (SELECT) and putting data (INSERT)
class DataController {
    static func getData(table: String, many: Bool, condition: String, completion: @escaping (Data?)->()) {
        let id = "21232f297a57a5a743894a0e4a801fc3"
        var urlStr = "http://baruchhaba.org/StudyBuddy/query.php?id=\(id)&type=select"
        if !many {
            urlStr += "_one"
        }
        urlStr += "&table=\(table)"
        if !condition.isEmpty {
            urlStr += "&condition=\(condition)"
        }
        urlStr = urlStr.replacingOccurrences(of: " ", with: "%20")
        urlStr = urlStr.replacingOccurrences(of: "\"", with: "%22")
        urlStr = urlStr.replacingOccurrences(of: ",", with: "%2C")
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                completion(data)
            }).resume()
        } else {
            completion("".data(using: .utf8))
        }
    }
    
    static func putData(table: String, values: [String], columns: [String], completion: @escaping (Bool)->()) {
        let id = "21232f297a57a5a743894a0e4a801fc3"
        var urlStr = "http://baruchhaba.org/StudyBuddy/query.php?id=\(id)&type=insert&table=\(table)&values="
        for i in 0 ... values.count - 2 {
            urlStr += "\"\(values[i])\", "
        }
        urlStr += "\"\(values[values.count - 1])\""
        if columns.count > 1 {
            urlStr += "&columns="
            for i in 0 ... columns.count - 2 {
                urlStr += "\(columns[i]), "
            }
            urlStr += "\(columns[columns.count - 1])"
        } else if columns.count > 0 {
            urlStr += "\(columns[columns.count - 1])"
        }
        urlStr = urlStr.replacingOccurrences(of: " ", with: "%20")
        urlStr = urlStr.replacingOccurrences(of: "\"", with: "%22")
        urlStr = urlStr.replacingOccurrences(of: ",", with: "%2C")
        print("URL: "+urlStr)
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
