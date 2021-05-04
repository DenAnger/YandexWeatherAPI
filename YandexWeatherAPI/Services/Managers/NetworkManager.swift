//
//  NetworkManager.swift
//  YandexWeatherAPI
//
//  Created by Denis Abramov on 28.04.2021.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let url = "https://api.weather.yandex.ru/v2/forecast?"
    private let apiKey = "080112cb-ad7d-48f8-80a8-314736dd4c31"
    private let apiField = "X-Yandex-API-Key"
    private let latitudeField = "&lat="
    private let longitudeField = "&lon="
    private let iconUrl = "https://yastatic.net/weather/i/icons/blueye/color/svg/"
    private let locationManager = LocationManager()
    
    func fetchWeatherForCities(for cities: [String],
                               weatherData: @escaping ([YandexWeatherData]) -> Void) {
        var dataArray: [YandexWeatherData] = []
        let group = DispatchGroup()
        
        for city in cities {
            group.enter()
            
            var url = self.url
            self.locationManager.getCoordinate(forCity: city) { (coordinate) in
                guard let coordinate = coordinate else {
                    group.leave()
                    return
                }
                url += self.latitudeField + coordinate.latitude
                url += self.longitudeField + coordinate.longitude
                
                guard let url = URL(string: url) else {
                    group.leave()
                    return
                }
                
                var request = URLRequest(url: url)
                request.addValue(self.apiKey, forHTTPHeaderField: self.apiField)
                
                let dataTask = URLSession.shared.dataTask(with: request) { data,
                                                                           response,
                                                                           error in
                    guard
                        let data = data,
                        error == nil,
                        let weatherData = self.parseJSON(withData: data) else {
                        group.leave()
                        print(error ?? "unknown error")
                        return
                    }
                    dataArray.append(weatherData)
                    group.leave()
                }
                dataTask.resume()
            }
        }
        group.notify(queue: .main) {
            weatherData(dataArray)
        }
    }
    
    private func parseJSON(withData data: Data) -> YandexWeatherData? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(YandexWeatherData.self,
                                                        from: data)
            return currentWeatherData
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
}

// MARK: - SVG Loader
extension NetworkManager {
    func loadIconData(iconName: String?) -> Data? {
        let url = self.iconUrl + (iconName ?? "ovc") + ".svg"
        
        if let url = URL(string: url),
           let data = try? Data(contentsOf: url) {
            return data
        }
        return nil
    }
}
