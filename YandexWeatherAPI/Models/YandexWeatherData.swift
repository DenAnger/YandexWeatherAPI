//
//  YandexWeatherData.swift
//  YandexWeatherAPI
//
//  Created by Denis Abramov on 28.04.2021.
//

import Foundation

struct YandexWeatherData: Codable {
    let geoObject: GeoObject
    let fact: Fact
    let forecast: [Forecast]
    
    enum CodingKeys: String, CodingKey {
        case geoObject = "geo_object"
        case fact
        case forecast
    }
}

struct GeoObject: Codable {
    let locality: Country
}

struct Country: Codable {
    let name: String
}

struct Fact: Codable {
    let temp: Int?
    let icon: String?
}

struct Forecast: Codable {
    let date: String?
    let parts: Parts
    let hours: [Hour]
}

struct Parts: Codable {
    let nightShort: Fact
    let dayShort: Fact
    
    enum CodingKeys: String, CodingKey {
        case nightShort = "night_short"
        case dayShort = "day_short"
    }
}

struct Hour: Codable {
    let hour: String?
    let temp: Int?
    let icon: String?
}
