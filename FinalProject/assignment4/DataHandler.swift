//
//  DataHandler.swift
//  assignment4
//
//  Created by Ryan Ballenger on 7/31/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import Foundation


class DataHandler:  NSObject, NSURLSessionDelegate, NSURLSessionTaskDelegate {
    
    func getSession() -> NSURLSession {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 30.0
        return NSURLSession(configuration: configuration)
    }
    
    
    func request(url: String, sender: InstrumentationTableViewController, completionHandler: ([String], [[(Int, Int)]]) -> Void) {
        
        let session = getSession()
        
        // parse the URL
        guard let nUrl = NSURL(string: url) else{
            print("URL error: \(url)")
            return
        }
        
        let task = session.dataTaskWithURL(nUrl) { (data, response, error) in
            
            // check for 200 status code
            if let status = (response as? NSHTTPURLResponse)?.statusCode {
                if status != 200 {
                    print("HTTP error: status code: \(status), \(NSHTTPURLResponse.localizedStringForStatusCode(status))")
                    return
                }
            }else {
            // output error info if there's no status code
                if let newError = error {
                    print("Network error: \(newError.localizedDescription)")
                }else{
                    print( "OS error: no error info provided")
                }
                return
            }
            
            // check error is nil
            guard (error == nil) else {
                print("Error: \(error)")
                return
            }
            
            // check data exists
            guard let data = data else {
                print("Error: no data")
                return
            }
            
            // parse data with Swift's default method
            var parsed: NSObject? = nil
            do {
                try parsed = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? NSObject
            } catch {
                print("Error: could not parse the data")
                return
            }
            
            // cast json to expected format
            guard let items = parsed as? [[String:AnyObject]] else {
                print("JSON format error: items")
                return
            }
            
            var titles: [String] = []
            
            var contents: [[(Int, Int)]] = []
            
            // get the title and set of points for each json entry
            for item in items{
                
                guard let title = item["title"] as? String, arr = item["contents"] as? [[Int]] else{
                    print("JSON format error: title or tuples")
                    return
                }
                
                titles.append(title)
                
                var pointSet: [(Int, Int)] = []
                
                for tuple in arr{
                    pointSet.append((tuple[0], tuple[1]))
                }
                
                contents.append(pointSet)
                
            }
            
            completionHandler(titles, contents)
            
        }
        
        task.resume()
        
    }
    
}
