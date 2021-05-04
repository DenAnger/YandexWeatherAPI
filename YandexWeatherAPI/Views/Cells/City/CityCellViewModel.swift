//
//  CityCellViewModel.swift
//  YandexWeatherAPI
//
//  Created by Denis Abramov on 30.04.2021.
//

import Foundation

// MARK: - Protocol
protocol CityCellViewModelProtocol {
    var cityName: String { get }
    var temp: String { get }
    var weatherIconData: Data? { get }
    
    init(weatherInfo: YandexWeatherData?)
}

// MARK: - Class
class CityCellViewModel: CityCellViewModelProtocol {
    var cityName: String
    var temp: String
    var weatherIconData: Data?
    
    required init(weatherInfo: YandexWeatherData?) {
        self.cityName = weatherInfo?.geoObject.locality.name ?? "..."
        
        if let temp = weatherInfo?.fact.temp {
            self.temp = temp > 0 ? "+\(temp)ºC" : "\(temp)ºC"
        } else {
            self.temp = "0ºC"
        }
        self.weatherIconData = NetworkManager.shared.loadIconData(iconName: weatherInfo?.fact.icon)
    }
}
