//
//  MovieDBAPI.swift
//  MovieDB
//
//  Created by Thinh Le Phuc on 4/11/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import Foundation

typealias ApiListMovieCallback = ([Movie]?, Error?) -> Void
typealias ApiMovieDetailCallback = (Movie?, Error?) -> Void

class MovieDB {
   
    // MARK: - Get movie list from TheMovieDB API
    class func getMovieList(completion: @escaping ApiListMovieCallback) {
        // Create request params
        let params = ["api_key" : ApiConstant.movieKey]
        // Create URL of API
        let requestURL = Util.getURLOfApi(basePath: ApiConstant.BASE_URL, apiPath: ApiConstant.ApiURL.listMovies, parameters: params)
        // Create session
        let session = URLSession(configuration: URLSessionConfiguration.default)
        // Create request
        let request = URLRequest(url: requestURL)
        //    request.setValue(ApiConstant.movieKey, forHTTPHeaderField: "api_key")
        // Create session data task and process
        let task = session.dataTask(with: request) {
            data, response, error in
            // Handle when error occurs
            guard error == nil else {
                completion(nil, error!)
                return
            }
            // Handle when can't read data
            guard let data = data  else {
                let dataError = "Data not found" as? Error
                completion(nil, dataError)
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
                    , let results = json["results"] as? [NSDictionary] {
                        completion(Movie.movies(array: results), nil)
                }
            } catch {
                let jsonError = "JSONSerialization Error" as? Error
                completion(nil, jsonError)
            }
        }
        // Start task
        task.resume()
    }
    
    // MARK: - Get detail of a movie with its ID
    class func getMovieDetail(id: Int, completion: @escaping ApiMovieDetailCallback) {
        // Create request params
        let params = ["api_key" : ApiConstant.movieKey]
        // Create URL of API
        let requestURL = Util.getURLOfApi(basePath: ApiConstant.BASE_URL, apiPath: ApiConstant.ApiURL.moviesDetail + "\(id)?", parameters: params)
        // Create session
        let session = URLSession(configuration: URLSessionConfiguration.default)
        // Create request to get data from API
        let request = URLRequest(url: requestURL)
        // Create session data task and process
        let task = session.dataTask(with: request) {
            data, response, error in
            // Handle when error occurs
            guard error == nil else {
                completion(nil, error!)
                return
            }
            // Handle when can't read data
            guard let data = data  else {
                let dataError = "Data not found" as? Error
                completion(nil, dataError)
                return
            }
      
            do {
                // Parse json and process it
                if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary {
                    completion(Movie.getDetails(detail: json), nil)
                }
            } catch {
                let jsonError = "JSONSerialization Error" as? Error
                completion(nil, jsonError)
            }

        }
        // Start task
        task.resume()
    
    }
}
