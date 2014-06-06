//
//  TemperatureTableViewCell.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/3/14.
//  Copyright (c) 2014 Two Toasters, LLC. All rights reserved.
//

import UIKit

class TemperatureTableViewCell: UITableViewCell, NibBackedView {
    
    @IBOutlet var label : UILabel
    @IBOutlet var dayLabel : UILabel
    
    class func nib() -> UINib {
        return UINib(nibName: "TemperatureTableViewCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
        label.font = Font.avenirBookWithSize(30.0)
        label.textColor = Color.grayDarkest()
        
        dayLabel.font = Font.avenirBookWithSize(30.0)
        dayLabel.textColor = Color.grayDarkest()
    }
    
}
