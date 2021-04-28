//
//  DataManager.swift
//  YandexWeatherAPI
//
//  Created by Denis Abramov on 28.04.2021.
//

import Foundation

struct DataManager {
    static var shared = DataManager()
    
    private let userDefaults = UserDefaults.standard
    private let citiesKey = "City"
    private let firstRunCities = ["Москва"]
    
    mutating func loadData() -> [String] {
        
        if let savedCities = userDefaults.object(forKey: citiesKey) as? [String] {
            return savedCities.sorted { $0<$1 }
        } else {
            saveData(cities: firstRunCities.sorted { $0<$1 })
            return firstRunCities
        }
    }
    
    private mutating func saveData(cities: [String]) {
        userDefaults.set(cities, forKey: citiesKey)
    }
}
