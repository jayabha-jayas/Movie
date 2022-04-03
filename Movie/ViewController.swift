//
//  ViewController.swift
//  Movie
//
//  Created by Jayabharathi S on 01/04/22.
//

import UIKit

struct Movie{
    var name: String!
    var description: String!
    var rating: Double!
    var logo: String!
}

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var movieList = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        fetchMovieData(url: "https://tw-mobile-hiring.web.app/interview_ios.json") { movieData in
            DispatchQueue.main.async {
                self.movieList.append(contentsOf: movieData)
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchMovieData(url: String, completion: @escaping ([Movie]) -> Void) {
        var movieData = [Movie]()
        let urlValue = Foundation.URL(string: url)
        let urlRequest = URLRequest(url: urlValue!)
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        urlSession.dataTask(with: urlRequest) { data, response, error in
            let json = try? JSONSerialization.jsonObject(with: data!, options: .json5Allowed) as? [String : Any]
            if let json = json {
                if let result = json["data"] as? [String : Any]{
                    if let cards = result["cards"] as? [[String : Any]]{
                        for value in cards {
                            if let val = value["content"] as? [String : Any]{
                                movieData.append(Movie(name: val["title"] as? String, description: val["description"] as? String, rating: val["rating"] as? Double, logo: val["movie_logo"] as? String))
                            }
                        }
                    }
                }
            }
            completion(movieData)
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCellIdentifier") as! MovieCell
        let movie = movieList[indexPath.row]
        cell.setContent(movie: movie)
        return cell
    }
}
