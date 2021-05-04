//
//  HourViewModel.swift
//  YandexWeatherAPI
//
//  Created by Denis Abramov on 04.05.2021.
//

import Foundation

// MARK: - Protocol
protocol HourViewModelProtocol {
    var currentHour: String { get }
    
    init(hour: Hour?)
}

class HourViewModel: HourViewModelProtocol {
    var currentHour: String
    
    required init(hour: Hour?) {
        self.currentHour = hour?.hour ?? "00"
    }
}
