//
//  HourlyWeatherCollectionViewCell.swift
//  Wheather App
//
//  Created by Sinan Kulen on 24.02.2022.
//

import UIKit
import Kingfisher

class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var hourLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var weatherIconImageView: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with item: Forecast)
    {
        temperatureLabel.text = String(Int(item.temperature.kelvinToCelcius()))
        weatherIconImageView.kf.setImage(with: item.weather.first?.iconURL)
        hourLabel.text = item.timeInterval.convertToHourString()
    }
}
