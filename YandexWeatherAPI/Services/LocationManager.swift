//
//  LocationManager.swift
//  YandexWeatherAPI
//
//  Created by Denis Abramov on 28.04.2021.
//

import CoreLocation

struct LocationManager {
    
    func getCoordinate(forCity cityName: String,
                       complitionHandler: @escaping(Coordinates2D?)->()) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(cityName) { (placemarks, error) in
            
            if error == nil {
                guard
                    let placemarks = placemarks,
                    let location = placemarks.first?.location?.coordinate else {
                    complitionHandler(nil)
                    return
                }
                let locationCoordinate = Coordinates2D(
                    latitude: location.latitude.description,
                    longitude: location.longitude.description
                )
                complitionHandler(locationCoordinate)
            } else {
                complitionHandler(nil)
            }
        }
    }
}
