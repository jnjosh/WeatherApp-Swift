//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/2/14.
//  Copyright (c) 2014 Two Toasters, LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        configureAppearance()
        return true
    }
    
    
    func configureAppearance() -> Void {
        UINavigationBar.appearance().titleTextAttributes = [ NSFontAttributeName : Font.avenirBookWithSize(18.0),
                                                             NSForegroundColorAttributeName : Color.grayDarkest() ]
    }
}

