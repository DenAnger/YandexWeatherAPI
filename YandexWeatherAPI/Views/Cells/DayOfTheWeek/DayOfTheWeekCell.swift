//
//  DayOfTheWeekCell.swift
//  YandexWeatherAPI
//
//  Created by Denis Abramov on 04.05.2021.
//

import UIKit

class DayOfTheWeekCell: UITableViewCell {
    
    @IBOutlet var dayOfTheWeekLabel: UILabel!
    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var dayTempLabel: UILabel!
    @IBOutlet var nightTempLabel: UILabel!
    
    var viewModel: DayOfTheWeekViewModelProtocol? {
        didSet {
            dayOfTheWeekLabel.text = "Monday"
            dayTempLabel.text = "10"
            nightTempLabel.text = "-10"
        }
    }
}
