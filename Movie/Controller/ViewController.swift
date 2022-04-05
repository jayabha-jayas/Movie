//
//  ViewController.swift
//  Movie
//
//  Created by Jayabharathi S on 01/04/22.
//

import UIKit

class ViewController: UIViewController, DetailsViewControllerProtocol {

    @IBOutlet weak var tableView: UITableView!
    private var movieList = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        loadMovies()
    }

    private func loadMovies() {
        movieList.append(Movie(name: "Dummy movie", description: "This is movie description.", rating: 10, logo: "", isLiked: false))

        NetworkService().fetchMovieData(url: Constants.movieListURL) { movieData in
            DispatchQueue.main.async {
                self.movieList.append(contentsOf: movieData)
                self.tableView.reloadData()
            }
        }
    }

    func callViewController(isLiked: Bool, rowNumber: Int) {
        movieList[rowNumber].isLiked = isLiked
        UserDefaults().set(movieList[rowNumber].isLiked, forKey: "\(rowNumber)")
        DispatchQueue.main.async {
            let currentSection = 0
            let indexPath = IndexPath(row: rowNumber, section: currentSection)
            self.tableView.beginUpdates()
            self.tableView.reloadRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailsViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailsViewController.movieName = movieList[indexPath.row].name
        detailsViewController.movieDescriptionValue = movieList[indexPath.row].description
        detailsViewController.movieURL = movieList[indexPath.row].logo
        detailsViewController.movieRatingValue = movieList[indexPath.row].rating
        detailsViewController.isLiked = movieList[indexPath.row].isLiked
        detailsViewController.rowNumber = indexPath.row
        detailsViewController.delegate = self
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
