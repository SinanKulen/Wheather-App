//
//  ClientService.swift
//  Wheather App
//
//  Created by Sinan Kulen on 22.02.2022.
//

import Foundation

protocol ClientNetworkServiceProtocol
{
    func getCurrentWheather(     latitude: Double,
                                 longitude: Double,
                                 completion: @escaping(CurrentWeatherDTO?,NetworkError?) -> Void)
    
    func getHourlyWheather(     latitude: Double,
                                longitude: Double,
                                completion: @escaping(HourlyWeatherDTO?,NetworkError?) -> Void)
}

class ClientNetworkService : ClientNetworkServiceProtocol
{
    private enum Endpoints : String
    {
        case currentWeather = "weather?lat=%f&lon=%f"
        case hourlyWeather = "onecall?lat=%f&lon=%f"
        
        func urlString(latitude: Double, longitude: Double) -> String
        {
            return String(format: self.rawValue, latitude, longitude)
        }
    }
    
    private let networkService : NetworkServiceProtocol = NetworkService()
    
    func getCurrentWheather(     latitude: Double,
                                 longitude: Double,
                                 completion: @escaping(CurrentWeatherDTO?,NetworkError?) -> Void)
    {
        let urlString = Endpoints.currentWeather.urlString(latitude: latitude, longitude: longitude)
        networkService.get(from: urlString, completion: completion)
    }
    
    func getHourlyWheather(     latitude: Double,
                                longitude: Double,
                                completion: @escaping(HourlyWeatherDTO?,NetworkError?) -> Void)
    {
        let urlString = Endpoints.hourlyWeather.urlString(latitude: latitude, longitude: longitude)
        networkService.get(from: urlString, completion: completion)
    }
}
