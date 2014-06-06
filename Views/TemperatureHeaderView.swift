//
//  TemperatureHeaderView.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/5/14.
//  Copyright (c) 2014 Two Toasters, LLC. All rights reserved.
//

import UIKit

class TemperatureHeaderView: UIView, NibBackedView {

    @IBOutlet var containerView: UIView
    @IBOutlet var temperatureLabel: UILabel
    @IBOutlet var cityLabel: UILabel
    
    class func nib() -> UINib {
        return UINib(nibName: "TemperatureHeaderView", bundle: nil)
    }
    
    
    init(frame: CGRect) {
        super.init(frame: frame)
        self.initializeView()
    }

    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        self.initializeView()
    }
    
    
    func initializeView() {
        TemperatureHeaderView.nib().instantiateWithOwner(self, options: nil)
        containerView.frame = bounds
        addSubview(containerView)

        temperatureLabel.font = Font.avenirBookWithSize(96.0)
        temperatureLabel.textColor = Color.grayDarkest()
        
        cityLabel.font = Font.avenirBookWithSize(17.0)
        cityLabel.textColor = Color.grayDarkest()

    }
    
}
