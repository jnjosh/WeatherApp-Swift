//
//  ViewController.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/2/14.
//  Copyright (c) 2014 Two Toasters, LLC. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource
{
    let cellIdentifier = "cellIdentifier"
    let headerIdentifier = "headerIdentifier"
    
    let client = APIClient()
    let locationManager = CLLocationManager()
    let dateFormatter = NSDateFormatter()
    let dateComponents = NSDateComponents()
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0

    @lazy var headerView = TemperatureHeaderView(frame: CGRectZero)
    let temperatureFormatter = NSNumberFormatter()
    
    @IBOutlet var tableView : UITableView

    var weatherItem: WeatherItem?
    var weatherItems: WeatherItem[]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh",
                                                            style: UIBarButtonItemStyle.Plain,
                                                            target: self,
                                                            action: "refresh")
        
        tableView.registerNib(TemperatureTableViewCell.nib(), forCellReuseIdentifier: cellIdentifier)
        tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerIdentifier)
        
        temperatureFormatter.maximumFractionDigits = 0
        temperatureFormatter.minimumFractionDigits = 0
        dateFormatter.dateFormat = "EEEE"

        headerView.temperatureLabel.text = "--"
        headerView.cityLabel.text = "--"
        
        refresh()
    }

    
    func refresh() {
        navigationItem.rightBarButtonItem.enabled = false;

        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: AnyObject[]!) {
        for item: AnyObject in locations {
            var location = item as CLLocation
            if location.horizontalAccuracy < 1000 {
                latitude = location.coordinate.latitude
                longitude = location.coordinate.longitude
                locationManager.stopUpdatingLocation()
                navigationItem.rightBarButtonItem.enabled = true
                
                fetchWeather()
                fetchForecast()
            }
        }
    }


    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error.localizedDescription)
    }
    
    
    func fetchWeather() {
        self.client.fetchWeatherWithLatitude(latitude, longitude: longitude, completion: { item in
            if item {
                let temperature = NSNumber(double: item!.fahrenheit())
                let temperatureString = self.temperatureFormatter.stringFromNumber(temperature)
                
                self.headerView.temperatureLabel.text = "\(temperatureString)º"
                self.headerView.cityLabel.text = item?.city
                self.tableView.reloadData()
            }
        })
    }
    
    
    func fetchForecast() {
        self.client.fetchWeatherForecastWithLatitude(latitude, longitude: longitude, completion: { items in
            if items {
                self.weatherItems = items!
                self.tableView.reloadData()
            }
        })
    }
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let item = self.weatherItems?[indexPath.row] as WeatherItem
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as TemperatureTableViewCell
        
        let temperature = NSNumber(double: item.fahrenheit())
        let temperatureString = self.temperatureFormatter.stringFromNumber(temperature)
        
        let calendar = NSCalendar.currentCalendar()
        
        dateComponents.day = indexPath.row + 1
        let date = calendar.dateByAddingComponents(dateComponents, toDate: NSDate(), options: NSCalendarOptions())
        
        cell.label.text = "\(temperatureString)º"
        cell.dayLabel.text = dateFormatter.stringFromDate(date)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell as UITableViewCell
    }
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return weatherItems ? weatherItems!.count : 0
    }
    
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 75.0
    }

    
    func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
        return headerView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
    }
    
    
    func tableView(tableView: UITableView!, viewForHeaderInSection section: Int) -> UIView! {
        let tableHeaderView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(headerIdentifier) as UITableViewHeaderFooterView
        tableHeaderView.addSubview(headerView)
        return headerView
    }
    
}
