//
//  CurrentWheatherDTO.swift
//  Wheather App
//
//  Created by Sinan Kulen on 23.02.2022.
//

import Foundation

// MARK: - CurrentWeatherDTO
struct CurrentWeatherDTO: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
    let date: Int
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case weather,main,name
    }
}

// MARK: - Main
struct Main: Codable {
    let temperature, feelsLike, maxTemperature, minTemperature: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case pressure, humidity
    }
}


