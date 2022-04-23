//
//  CurrentWeatherData.swift
//  WeatherAPI
//
//  Created by Евгений Доброволец on 23.04.2022.
//

import Foundation

struct CurrentWeatherData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey { //enum используем для изменения ключа
        case temp
        case feelsLike = "feels_like"
    }
}

struct Weather: Codable {
    let id: Int
}
