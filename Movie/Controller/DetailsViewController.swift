//
//  DetailsViewController.swift
//  Movie
//
//  Created by Jayabharathi S on 04/04/22.
//

import UIKit

protocol DetailsViewControllerProtocol {
    func callViewController(isLiked: Bool, rowNumber: Int)
}

class DetailsViewController: UIViewController {

    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var isLikeButton: UIButton!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieRating: UILabel!

    var movieName: String?
    var movieDescriptionValue: String?
    var movieURL: String?
    var movieRatingValue: Double?
    var isLiked: Bool?
    var delegate: DetailsViewControllerProtocol?
    var rowNumber: Int?

    @IBAction func tapButton(_ sender: UIButton) {
        isLiked!.toggle()
        sender.setImage(UIImage(systemName: isLiked! ? "star.fill" : "star"), for: .normal)
        delegate?.callViewController(isLiked: isLiked!, rowNumber: rowNumber!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        movieLabel.text = movieName
        movieLabel.numberOfLines = 0
        movieDescription.text = movieDescriptionValue
        movieDescription.numberOfLines = 0
        setMovieLogo(movieLogoURL: movieURL!)
        movieRating.text = "\(movieRatingValue!)/10"
        isLikeButton.setImage(UIImage(systemName: isLiked! ? "star.fill" : "star"), for: .normal)
        isLikeButton.configuration?.title = ""
    }

    func setMovieLogo(movieLogoURL: String) {
        if let url = URL(string: movieLogoURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.moviePoster.image = UIImage(data: data)
                        if self.moviePoster.image == nil {
                            self.moviePoster.image = UIImage(named: "MoviePoster/defaultPoster")
                        }
                    }
                }
            }
        } else {
            moviePoster.image = UIImage(named: "MoviePoster/defaultPoster")
        }
    }
}
