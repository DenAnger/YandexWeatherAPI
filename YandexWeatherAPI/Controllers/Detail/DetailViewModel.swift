//
//  DetailViewModel.swift
//  YandexWeatherAPI
//
//  Created by Denis Abramov on 30.04.2021.
//

import Foundation

// MARK: - Protocol
protocol DetailViewModelProtocol {
    var cityWeatherData: YandexWeatherData? { get }
    var cityName: String { get }
    var currentTemp: String { get }
    var weatherIconData: Data? { get }
    
    init(cityWeatherData: YandexWeatherData?)
    
    func hoursCellViewModel(at indexPath: IndexPath) -> HourViewModelProtocol?
    func dayOfTheWeekCellViewModel(at indexPath: IndexPath) -> DayOfTheWeekViewModelProtocol?
    func numberOfRowsAtTableView() -> Int
}

// MARK: - Class
class DetailViewModel: DetailViewModelProtocol {
    
    var cityWeatherData: YandexWeatherData?
    var cityName: String {
        cityWeatherData?.geoObject.locality.name ?? "..."
    }
    var currentTemp: String {
        guard let temp = cityWeatherData?.fact.temp else { return "0ºC" }
        
        switch temp {
        case 1...99:
            return "+\(temp)ºC"
        case 0:
            return "0ºC"
        default:
            return "\(temp)ºC"
        }
    }
    var weatherIconData: Data? {
        NetworkManager.shared.loadIconData(iconName: cityWeatherData?.fact.icon)
    }
    
    required init(cityWeatherData: YandexWeatherData?) {
        self.cityWeatherData = cityWeatherData
    }
    
    func hoursCellViewModel(at indexPath: IndexPath) -> HourViewModelProtocol? {
        return nil
    }
    
    func dayOfTheWeekCellViewModel(at indexPath: IndexPath) -> DayOfTheWeekViewModelProtocol? {
        return nil
    }
    
    func numberOfRowsAtTableView() -> Int {
        return cityWeatherData?.forecasts.count ?? 2 - 1
    }
}
