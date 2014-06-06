//
//  APIClient.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/2/14.
//  Copyright (c) 2014 Two Toasters, LLC. All rights reserved.
//

import UIKit

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
        let URL = NSURL(string: URLString)
        let request = NSURLRequest(URL: URL)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            if !response {
                completion(nil)
                return;
            }
            
            var jsonError: NSError? = nil
            var dictionary : AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError)
            
            dispatch_async(dispatch_get_main_queue(), {
                var item = WeatherItem(temperatureDictionary: dictionary as Dictionary)
                completion(item);
            })
        })
    }
    
    
    func fetchWeatherForecastWithLatitude(latitude: Double, longitude: Double, completion:((WeatherItem[]?) -> Void)!) {
        let URLString = baseURLString.stringByAppendingFormat(forecastPathFormat, latitude, longitude)
        let URL = NSURL(string: URLString)
        let request = NSURLRequest(URL: URL)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            if !response {
                completion(nil)
                return;
            }
            
            var jsonError: NSError? = nil
            var dictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(), error: &jsonError) as NSDictionary
            
            dispatch_async(dispatch_get_main_queue(), {
                let list = dictionary["list"] as NSArray
                var items = WeatherItem[]()

                list.enumerateObjectsUsingBlock({ object, index, stop in
                    var listItem = object as NSDictionary
                    
                    var temp = listItem["temp"] as NSDictionary
                    var day: AnyObject = temp["day"]
                    
                    var number = self.formatter.numberFromString(day.description).doubleValue
                    var weatherItem = WeatherItem(kelvinDegrees: number, cityName: "")
                    
                    items.append(weatherItem)
                })
                
                completion(items)

            })
        })
    }
}
