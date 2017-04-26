//
//  ApiConstant.swift
//  MovieDB
//
//  Created by Thinh Le Phuc on 4/14/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//ß

import UIKit

struct ApiConstant {

    // MARK: - Base URL
    static let BASE_URL = "https://api.themoviedb.org/3"
    static let movieKey = "4581e2c7ecaf5e3d44427ae7ece2376d"
    
    // MARK: - URL of APIs
    struct ApiURL {
        static let listMovies = "/movie/now_playing?"
        static let moviesDetail = "/movie/"
    }

}
