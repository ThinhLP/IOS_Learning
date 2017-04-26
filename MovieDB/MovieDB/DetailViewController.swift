//
//  DetailViewController.swift
//  MovieDB
//
//  Created by Thinh Le Phuc on 4/11/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var detailView: UIView!
    
    var movieID: Int?
    var dataSource: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load data to view controller
        loadMovieDetail()
        // Customize navigation bar
        configureNavigation()        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Configure navigation bar
    func configureNavigation() {
        self.navigationItem.title = "Details"
    }
    
    // MARK: - Load movie detail from api by id
    func loadMovieDetail() {
        // Show activity indicator when loading data from API
        showActivityIndicator()
        MovieDB.getMovieDetail(id: movieID!) {
            movie, error in
            // Handle when error occurs
            guard error == nil, let movie = movie  else {
                // Hidden activity indicator when errors occur
                DispatchQueue.main.async {
                    self.hiddenActivityIndicator()
                }
                return
            }
            // Set movie detail to label
            DispatchQueue.main.async {
                // Stored movie
                self.dataSource = movie
                // Show detail
                self.showMovieDetailToViewController(movie: movie)
                // Hidden activity indicator after loading successfully
                self.hiddenActivityIndicator()
            }
        }
    }
    
    // MARK: - Show movie detail to view controller
    func showMovieDetailToViewController(movie: Movie) {
        guard let revenue = movie.revenue, let runtime = movie.runtime, let data = movie.posterData  else {
            return
        }
        self.movieTitleLabel.text = movie.title
        self.releaseDateLabel.text = movie.releaseDate
        self.revenueLabel.text = "$\(revenue)"
        self.durationLabel.text = "\(runtime) mins"
        self.overviewLabel.text = movie.overview
        self.moviePosterImageView.image = UIImage(data: data)
    }
    
    // MARK: - Set status of activity indicator
    func showActivityIndicator() {
        detailView.isHidden = true
        activityIndicator.isHidden = false
        // Start animating for activity indicator
        activityIndicator.startAnimating()
    }
    func hiddenActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        detailView.isHidden = false
    }

}
