//
//  File.swift
//  MovieDB
//
//  Created by Thinh Le Phuc on 4/14/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import Foundation

class Util {
    
    // MARK: - Get url with path and parameters
    static func getURLOfApi(basePath: String, apiPath: String, parameters: [String:String]?) -> URL {
        var url = basePath + apiPath
        guard let params = parameters else {
            return URL(string: url)!
        }
        for key in params.keys {
            let param = key + "=" + params[key]! + "&"
            url += param
        }
        let index = url.index(before: url.endIndex)
        url = url.substring(to: index)
        return URL(string: url)!
    }
    
    // MARK: - Get Data image with path and size
    static func getImageDataWithSize(path: String, size: Int) -> Data? {
        let imageURL = "https://image.tmdb.org/t/p/w\(size)" + path
        let url = URL(string: imageURL)
        do {
            let posterData = try Data(contentsOf: url!)
            return posterData
        } catch {
            return nil
        }
    }
}
