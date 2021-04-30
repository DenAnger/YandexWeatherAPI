//
//  CityCell.swift
//  YandexWeatherAPI
//
//  Created by Denis Abramov on 30.04.2021.
//

import UIKit

class CityCell: UITableViewCell {
    
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var conditionIcon: UIImageView!

    var viewModel: CityCellViewModelProtocol! {
        didSet {
            cityNameLabel.text = viewModel.cityName
            tempLabel.text = viewModel.temp
        }
    }
}
