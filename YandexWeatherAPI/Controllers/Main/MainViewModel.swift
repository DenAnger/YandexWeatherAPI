//
//  MainViewModel.swift
//  YandexWeatherAPI
//
//  Created by Denis Abramov on 30.04.2021.
//

import UIKit

// MARK: - Protocol
protocol MainViewModelProtocol: AnyObject {
    var weatherData: [YandexWeatherData?]? { get }
    var numberOfRows: Int { get }
    var reloadData: () -> Void { get }
    
    func fetchWeatherData(closure: @escaping() -> Void)
    func showCityWeather(for city: String?,
                         weatherData: @escaping(YandexWeatherData?) -> Void)
    func cellViewModel(at indexPath: IndexPath) -> CityCellViewModelProtocol?
}

// MARK: - Class
class MainViewModel: MainViewModelProtocol {
    var weatherData: [YandexWeatherData?]?
    var numberOfRows: Int { self.weatherData?.count ?? 0 }
    var reloadData: () -> Void
    
    init(reloadData: @escaping() -> Void) {
        self.reloadData = reloadData
    }
    
    func fetchWeatherData(closure: @escaping() -> Void) {
        NetworkManager.shared.fetchWeatherForCities(for: DataManager.shared.loadData()) { (data) in
            
            if !data.isEmpty {
                DispatchQueue.main.async {
                    self.weatherData = data.sorted { $0.geoObject.locality.name <
                        $1.geoObject.locality.name
                    }
                    self.reloadData()
                }
                closure()
            }
        }
    }
    
    func showCityWeather(for city: String?,
                         weatherData: @escaping (YandexWeatherData?) -> Void) {
        
        if let city = city,
           city.count >= 2 {
            let locationManager = LocationManager()
            locationManager.getCoordinate(forCity: city) { (coordinates) in
                
                if let _ = coordinates {
                    NetworkManager.shared.fetchWeatherForCities(for: [city]) { (data) in
                        
                        if data.isEmpty {
                            weatherData(nil)
                        } else {
                            weatherData(data.first)
                        }
                    }
                } else {
                    weatherData(nil)
                }
            }
        }
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CityCellViewModelProtocol? {
        CityCellViewModel(weatherInfo: self.weatherData?[indexPath.row])
    }
}
