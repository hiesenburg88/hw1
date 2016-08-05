//
//  SharedNetworking.swift
//  photoapp
//
//  Created by Mark McDonald on 8/2/16.
//  Copyright © 2016 Mark McDonald. All rights reserved.
//

import Foundation
import UIKit

class SharedNetworking
{
    lazy var configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.configuration)
    
    let url: NSURL
    var pictures = [UIImage]()
    private init(url: NSURL) {
        self.url = url
    }
    
    typealias ImageDataHandler = (NSData -> Void)
    
    func downloadImage(completion: ImageDataHandler)
    {
               
        let request = NSURLRequest(URL: self.url)
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) in
//         UIApplication.sharedApplication().networkActivityIndicatorVisible = true   
            if error == nil {
                if let httpResponse = response as? NSHTTPURLResponse {
                    switch (httpResponse.statusCode) {
                    case 200:
                        if let data = data {
                            completion(data)
                        }
                    default:
                        print(httpResponse.statusCode)
                    }
                }
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        
        dataTask.resume()
    }
    
    
    //http://www.kaleidosblog.com/uiimage-from-url-with-swift

    
    
    
    }

extension SharedNetworking
{
    static func parseJSONFromData(jsonData: NSData?) -> [String : AnyObject]?
    {
      if let data = try jsonData {
            do {
                let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? [String : AnyObject]
                return jsonDictionary
                
            } catch let error as NSError {
                print("error processing json data: \(error.localizedDescription)")
            }
        }
        
        return nil
    }
    
    
}


