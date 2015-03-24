//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/2/14.
//  Copyright (c) 2014 Two Toasters, LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        configureAppearance()
        return true
    }
    
    
    func configureAppearance() -> Void {
        if let font = Font.avenirBookWithSize(18.0) {
            UINavigationBar.appearance().titleTextAttributes = [ NSFontAttributeName : font, NSForegroundColorAttributeName : Color.grayDarkest() ]
        }
    }
}

