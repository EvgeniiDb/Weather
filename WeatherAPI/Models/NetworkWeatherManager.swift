//
//  NetworkWeatherManager.swift
//  WeatherAPI
//
//  Created by Евгений Доброволец on 23.04.2022.
//

import Foundation

class NetworkWeatherManager {
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    func fetchCurrentWeather(forCity city: String) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
//                let dataString = String(data: data, encoding: .utf8) //отображаем JSON в виде строки
//                print(dataString!)                                   //и распечатываем его в консоль
                if let currentWeather = self.parseJSON(withData: data) {
                    self.onCompletion?(currentWeather)
                }
            }
        }
        task.resume()
        
    }
    
    func parseJSON(withData data: Data) -> CurrentWeather? {
        
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            //print(currentWeatherData.main.temp) // распарсили данные и вывели в консоль (main и температуру)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else {
                return nil
            }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
