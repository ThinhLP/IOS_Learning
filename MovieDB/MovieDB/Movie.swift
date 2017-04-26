//
//  Movie.swift
//  MovieDB
//
//  Created by Thinh Le Phuc on 4/11/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import Foundation

class Movie {
    let id: Int
    let title: String?
    let overview: String?
    let posterData: Data?
    let revenue: Int?
    let runtime: Int?
    let releaseDate: String?
    let posterPath: String?
    
    init(dictionary: NSDictionary) {
        id = dictionary["id"] as! Int
        title = dictionary["title"] as? String
        overview = dictionary["overview"] as? String
        posterPath = dictionary["poster_path"] as? String
        revenue = dictionary["revenue"] as? Int
        runtime = dictionary["runtime"] as? Int
        releaseDate = dictionary["release_date"] as? String
        posterData = posterPath == nil ? nil : Util.getImageDataWithSize(path: posterPath!, size: Constant.MovieImage.big)
    }
    
    class func movies(array: [NSDictionary]) -> [Movie] {
        var moviesList = [Movie]()
        for dictionary in array {
            let movie = Movie(dictionary: dictionary)
            moviesList.append(movie)
        }
        return moviesList
    }
    
    class func getDetails(detail: NSDictionary) -> Movie {
        return Movie(dictionary: detail)
    }
    
    
    
}
