//
//  APIClient.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/2/14.
//  Copyright (c) 2014 Two Toasters, LLC. All rights reserved.
//

import UIKit
import Runes
import Argo

class APIClient: NSObject
{
    let baseURLString = "http://api.openweathermap.org/data/2.5"
    let weatherPathFormat = "/weather?lat=%f&lon=%f"
    let forecastPathFormat = "/forecast/daily?lat=%f&lon=%f&cnt=5&mode=json"
    
    var queue: NSOperationQueue = NSOperationQueue()
    var connection: NSURLConnection?
    var delegate: AnyObject?
    var formatter = NSNumberFormatter()
    
    func fetchWeatherWithLatitude(latitude: Double, longitude: Double, completion:((WeatherItem?) -> Void)!) {
        let URLString = baseURLString.stringByAppendingFormat(weatherPathFormat, latitude, longitude)
        
        if let URL = NSURL(string: URLString) {
            let request = NSURLRequest(URL: URL)
            
            NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: {
                (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                
                if response == nil {
                    completion(nil)
                    return;
                }
                
                var jsonError: NSError? = nil
                if let result: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &jsonError) {
                    dispatch_async(dispatch_get_main_queue(), {
                        let value = JSONValue.parse(result)
                        let item = WeatherItem.decode(value)
                        completion(item)
                    })
                }
            })
        }
    }
    
    func fetchWeatherForecastWithLatitude(latitude: Double, longitude: Double, completion:(([WeatherItem]?) -> Void)!) {
        let URLString = baseURLString.stringByAppendingFormat(forecastPathFormat, latitude, longitude)
        
        if let URL = NSURL(string: URLString) {
            let request = NSURLRequest(URL: URL)
            
            NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: {
                (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                
                if response == nil {
                    completion(nil)
                    return;
                }
                
                var jsonError: NSError? = nil
                if let result: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &jsonError) {
                    dispatch_async(dispatch_get_main_queue(), {
                        let list = JSONValue.parse(result)
                        let item = Forecast.decode(list)
                        
                        if let items = item?.weatherItems {
                            let weatherItems = items.map { item in
                                return WeatherItem(kelvin: item.kelvin, city: nil)
                            }
                            
                            completion(weatherItems)
                        }
                    })
                }
            })
        }
    }
}
