//
//  NetworkService.swift
//  Movie
//
//  Created by Jayabharathi S on 05/04/22.
//

import Foundation

class NetworkService {
    func fetchMovieData(url: String, completion: @escaping ([Movie]) -> Void) {
        var movieData = [Movie]()
        let urlValue = Foundation.URL(string: url)
        let urlRequest = URLRequest(url: urlValue!)
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)

        urlSession.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: .json5Allowed) as? [String : Any]
                if let json = json {
                    if let result = json["data"] as? [String : Any]{
                        if let cards = result["cards"] as? [[String : Any]]{
                            for value in cards {
                                if let val = value["content"] as? [String : Any]{
                                    movieData.append(Movie(name: val["title"] as? String, description: val["description"] as? String, rating: val["rating"] as? Double, logo: val["movie_logo"] as? String, isLiked: false))
                                }
                            }
                        }
                    }
                }
            }
            completion(movieData)
        }.resume()
    }
}
