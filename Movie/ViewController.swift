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
    var isLiked: Bool!
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DetailsViewControllerProtocol {
    func callViewController(isLiked: Bool, rowNumber: Int) {
        movieList[rowNumber].isLiked = isLiked
        UserDefaults().set(movieList[rowNumber].isLiked, forKey: "\(rowNumber)")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView!
    var movieList = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

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
                                movieData.append(Movie(name: val["title"] as? String, description: val["description"] as? String, rating: val["rating"] as? Double, logo: val["movie_logo"] as? String, isLiked: false))
                            }
                        }
                    }
                }
            }
            completion(movieData)
        }.resume()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailsViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailsViewController.movieName = movieList[indexPath.row].name
        detailsViewController.movieDescriptionValue = movieList[indexPath.row].description
        detailsViewController.isLiked = movieList[indexPath.row].isLiked
        detailsViewController.rowNumber = indexPath.row
        detailsViewController.delegate = self
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCellIdentifier") as! MovieCell
        let movie = movieList[indexPath.row]
        cell.setContent(movie: movie)
        movieList[indexPath.row].isLiked = UserDefaults().bool(forKey: "\(indexPath.row)")
        cell.isLiked.setImage(UIImage(systemName: movieList[indexPath.row].isLiked ? "star.fill" : "star"), for: .normal)
        cell.actionBlock = { sender in
            self.movieList[indexPath.row].isLiked.toggle()
            let isLikedValue = self.movieList[indexPath.row].isLiked
            UserDefaults().set(isLikedValue, forKey: "\(indexPath.row)")
            sender.setImage(UIImage(systemName: isLikedValue! ? "star.fill" : "star"), for: .normal)
        }
        return cell
    }
}
