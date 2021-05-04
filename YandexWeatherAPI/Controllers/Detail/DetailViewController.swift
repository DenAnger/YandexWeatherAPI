//
//  DetailViewController.swift
//  YandexWeatherAPI
//
//  Created by Denis Abramov on 28.04.2021.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var currentTempLabel: UILabel!
    @IBOutlet var weatherIconView: UIImageView!
    
    @IBOutlet var hourCollectionView: UICollectionView!
    @IBOutlet var dayOfTheWeekTableView: UITableView!
    
    var weatherData: YandexWeatherData?
    var viewModel: DetailViewModelProtocol! {
        didSet {
            cityNameLabel.text = viewModel.cityName
            currentTempLabel.text = viewModel.currentTemp
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }

    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView()
    }
    
    func loadingView() {
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        dayOfTheWeekTableView.rowHeight = 50
        viewModel = DetailViewModel(cityWeatherData: weatherData)
    }
}

// MARK: - Hour collection view data source
extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        22
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourCell",
                                                      for: indexPath) as! HourCell
        let cellViewModel = self.viewModel.hoursCellViewModel(at: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
}

// MARK: - Hour collection view delegate flow layout
extension DetailViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 50, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

// MARK: - Weekday TableView Data Source
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsAtTableView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayOfTheWeekCell") as! DayOfTheWeekCell
        cell.viewModel = viewModel.dayOfTheWeekCellViewModel(at: indexPath)
        return cell
    }
}
