//
//  MainTableViewController.swift
//  YandexWeatherAPI
//
//  Created by Denis Abramov on 28.04.2021.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var viewModel: MainViewModelProtocol! {
        didSet {
            viewModel.fetchWeatherData(closure: {
                self.activityIndicator.stopAnimating()
            })
        }
    }
    
    private let activityIndicator = UIActivityIndicatorView()
    private let segueID = "goToDetailView"

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLoading()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell",
                                                 for: indexPath) as! CityCell
        let cellViewModel = self.viewModel.cellViewModel(at: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: segueID,
                          sender: viewModel.weatherData![indexPath.row])
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID,
           let detailViewController = segue.destination as? DetailViewController,
           let currentWeather = sender as? YandexWeatherData {
            detailViewController.weatherData = currentWeather
        }
    }

    // MARK: - Methods
    func viewLoading() {
        tableView.rowHeight = 50
        view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        viewModel = MainViewModel(reloadData: self.tableView.reloadData)
    }
}
