//
//  DayOfTheWeekViewModel.swift
//  YandexWeatherAPI
//
//  Created by Denis Abramov on 04.05.2021.
//

import Foundation

// MARK: - Protocol
protocol DayOfTheWeekViewModelProtocol {
    var currentDayOfTheWeek: String { get }
    var conditionIconData: Data? { get }
    var dayTemp: String { get }
    var nightTemp: String { get }
    
    init(forecast: Forecast?, conditionIconData: Data?)
}

// MARK: - Class
class DayOfTheWeekViewModel: DayOfTheWeekViewModelProtocol {
    var currentDayOfTheWeek: String
    var conditionIconData: Data?
    var dayTemp: String
    var nightTemp: String
    
    required init(forecast: Forecast?, conditionIconData: Data?) {
        let dayOfTheWeek = DayOfTheWeek()
        currentDayOfTheWeek = dayOfTheWeek.getDayOfTheWeek(fromDate: forecast?.date)
        
        if let temp = forecast?.parts.dayShort.temp {
            self.dayTemp = temp > 0 ? "+\(temp)" : "\(temp)"
        } else {
            self.dayTemp = "0"
        }
        
        if let temp = forecast?.parts.nightShort.temp {
            self.nightTemp = temp > 0 ? "+\(temp)" : "\(temp)"
        } else {
            self.nightTemp = "0"
        }
        self.conditionIconData = conditionIconData
    }
}
