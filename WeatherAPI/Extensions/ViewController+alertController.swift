//
//  File.swift
//  WeatherAPI
//
//  Created by Евгений Доброволец on 23.04.2022.
//

import Foundation
import UIKit

extension ViewController {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping (String) -> Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { tf in
            let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Viena"]
            tf.placeholder = cities.randomElement()
        }
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                //print("search info for the \(cityName)") выводим в консоль
                //self.networkWeatherManager.fetchCurrentWeather(forCity: cityName) //реализация ввода поиска города через Alert
                let city = cityName.split(separator: " ").joined(separator: "%20") //реализация названия города, состоящего из 2-х слов
                completionHandler(city) //реализация Alert через клоужер
                
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
        
    }
}
