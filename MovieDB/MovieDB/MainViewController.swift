//
//  ViewController.swift
//  MovieDB
//
//  Created by Thinh Le Phuc on 4/11/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var numberOfMoviesToShow: Int = 10
    var moviesList: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Load movie from API
        loadMovieListFromAPI()
        // Configure table view
        configureTableView()
        // Customize navigation bar
        configureNavigation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Configure for table view
    func configureTableView()  {
        self.automaticallyAdjustsScrollViewInsets = false
        // Table view datasource
        movieTableView.dataSource = self
        movieTableView.delegate = self
        // Set automatic dimension for tableview
        movieTableView.rowHeight = UITableViewAutomaticDimension
        movieTableView.estimatedRowHeight = 120
    }
    
    // MARK: - Configure navigation bar
    func configureNavigation() {
        self.navigationItem.title = "Movies"
    }

    // MARK: - Load movie list from MovieDB API
    func loadMovieListFromAPI() {
        // Show activity indicator when loading data from API
        self.showActivityIndicator()
        MovieDB.getMovieList() {
            movies, error in
            // Handle when error occurs
            guard error == nil, let movies = movies else {
                // Hidden acitivity indicator when errors occur
                DispatchQueue.main.async {
                    self.hiddenActivityIndicator()
                }
                return
            }
            // Stored movies in list and reload table view to show data
            self.moviesList = movies
            self.reloadData()
        }
    }
    
    func reloadData () {
        DispatchQueue.main.async {
            // Reload table view
            self.movieTableView.reloadData()
            // Hidden activity indicator after loading successfully
            self.hiddenActivityIndicator()
        }
    }
    
    // MARK: - Configure segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == Constant.Identifier.viewDetailSegue, let destination = segue.destination as? DetailViewController
            , let cell = sender as? UITableViewCell
            , let indexPath = movieTableView.indexPath(for: cell) {
            destination.movieID = moviesList[indexPath.row].id
        }
    }
    
    // MARK: - Set status of activity indicator
    func showActivityIndicator() {
        activityIndicator.isHidden = false
        // Start animating for activity indicator
        activityIndicator.startAnimating()
    }
    func hiddenActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }


}

// MARK: - Process for TableViewDataSource
extension MainViewController: UITableViewDataSource {
    // MARK: - Set number of section in table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - Set number of row in a section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfMoviesToShow < moviesList.count ? numberOfMoviesToShow : moviesList.count
    }
    
    // MARK: - Configure for each cell of TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.movieTableViewCell, for: indexPath) as! MovieTableViewCell
        cell.dataSource = moviesList[indexPath.row]
        return cell
    }

}

// MARK: - Process for TableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    // MARK: - Show more movies when scroll to bottom
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (numberOfMoviesToShow >= moviesList.count) {
            return
        }
        let lastIndex = numberOfMoviesToShow - 1
        if indexPath.row == lastIndex {
            numberOfMoviesToShow += 1
            movieTableView.reloadData()
        }
    }
    
    // MARK: - Deselect row when selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieTableView.deselectRow(at: indexPath, animated: true)
    }
}


