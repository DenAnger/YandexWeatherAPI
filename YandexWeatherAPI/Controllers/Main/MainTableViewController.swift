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
    
    private var activityIndicator = UIActivityIndicatorView()

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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Methods
    func viewLoading() {
        tableView.rowHeight = 50
        view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        viewModel = MainViewModel(reloadData: self.tableView.reloadData)
    }
}