//
//  HourCell.swift
//  YandexWeatherAPI
//
//  Created by Denis Abramov on 04.05.2021.
//

import UIKit

class HourCell: UICollectionViewCell {
    @IBOutlet var hourLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var weatherImageView: UIImageView!
    
    var viewModel: HourViewModelProtocol! {
        didSet {
            hourLabel.text = "13"
            weatherImageView.image = UIImage(systemName: "sun.max.fill")
            tempLabel.text = "12"
        }
    }
}
