//
//  LocationManager.swift
//  Wheather App
//
//  Created by Sinan Kulen on 21.02.2022.
//

import Foundation
import MapKit

protocol LocationManagerDelegate : NSObject
{
    func didUpdateLocations(latitude: Double, longitude: Double)
}

protocol LocationManagerProtocol
{
    func requestLocation()
}

class LocationManager : NSObject, LocationManagerProtocol
{
    private lazy var locationManager : CLLocationManager =
    {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()

    weak var delegate : LocationManagerDelegate?
    
    func requestLocation()
    {
        switch locationManager.authorizationStatus
        {
        case .authorizedAlways, .authorizedWhenInUse :
            locationManager.startUpdatingLocation()
        case .notDetermined :
            locationManager.requestWhenInUseAuthorization()
        default :
            break
        }
    }
}

extension LocationManager : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first?.coordinate else { return }
        let latitude = Double(coordinate.latitude)
        let longitude = Double(coordinate.longitude)
        self.delegate?.didUpdateLocations(latitude: latitude, longitude: longitude)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestLocation()
    }
}
