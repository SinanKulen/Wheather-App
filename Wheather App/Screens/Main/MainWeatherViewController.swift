//
//  ViewController.swift
//  Wheather App
//
//  Created by Sinan Kulen on 18.02.2022.
//

import UIKit

class MainWeatherViewController: UIViewController {
    
    @IBOutlet var hourlyWeatherContainerView: UIView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    private let networkService : ClientNetworkServiceProtocol = ClientNetworkService()
    private lazy var locationService : LocationManagerProtocol = {
        let locationManager = LocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    private var HourlyWeatherViewControler : HourlyWeatherViewController!
    private var isHourlyWeatherAdded = false
    
    private var latitude : Double?
    private var longitude : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationService.requestLocation()
        }
    
    func addHourlyWeatherView(latitude:Double?,
                              longitude:Double?)
    {
        HourlyWeatherViewControler = HourlyWeatherViewController(nibName : HourlyWeatherViewController.nibName,
                                             bundle : nil)
        HourlyWeatherViewControler.configure(networkService: networkService, latitude: latitude, longitude: longitude)
        HourlyWeatherViewControler.view.frame = hourlyWeatherContainerView.bounds
        hourlyWeatherContainerView.clipsToBounds = true
        hourlyWeatherContainerView.addSubview(HourlyWeatherViewControler.view)
    }
    
    func getCurrentWeather(latitude: Double, longitude: Double, completion: @escaping (CurrentWeatherDTO?) -> Void)
    {
        networkService.getCurrentWheather(latitude: latitude, longitude: longitude) { response, error in
            if error != nil
            {
                completion(nil)
            } else {
                completion(response)
            }
        }
    }
    
    func updateLabel(latitude: Double, longitude: Double)
    {
        getCurrentWeather(latitude: latitude, longitude: longitude) { [weak self]    response in
            guard let self = self else { return }
            guard let weather = response else { return }
            
            DispatchQueue.main.async {
                self.nameLabel.text = weather.name
                self.temperatureLabel.text = String(Int(weather.main.temperature.kelvinToCelcius())) + "℃"
                self.dateLabel.text = weather.date.convertToString()
            }
        }
    }
}

extension MainWeatherViewController: LocationManagerDelegate
{
    func didUpdateLocations(latitude: Double, longitude: Double) {
        if !isHourlyWeatherAdded
        {
            addHourlyWeatherView(latitude: latitude, longitude: longitude)
            isHourlyWeatherAdded.toggle()
        }
        updateLabel(latitude: latitude, longitude: longitude)
    }
}
