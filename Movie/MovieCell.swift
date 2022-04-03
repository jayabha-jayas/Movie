//
//  MovieCell.swift
//  Movie
//
//  Created by Jayabharathi S on 01/04/22.
//

import UIKit

class MovieCell : UITableViewCell {
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var descriptionValue : UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var isLiked: UIButton!
    var isLikedValue: Bool!
    
    @IBAction func isLikedPressed(_ sender: Any) {
        isLikedValue.toggle()
        isLiked.setImage(UIImage(systemName: isLikedValue ? "star.fill" : "star"), for: .normal)
    }
    
    func setContent(movie : Movie) {
        setMovieName(movieName: movie.name)
        setMovieDescription(movieDescription: movie.description)
        setMovieRating(movieRating: String(movie.rating!))
        setLikedMovie(isLikedMovie: movie.isLiked)
        setMovieLogo(movieLogoURL: movie.logo)
    }
    
    func setMovieName(movieName: String) {
        name.text = movieName
        name.numberOfLines = 0
    }
    
    func setMovieDescription(movieDescription: String) {
        descriptionValue.text = movieDescription
        descriptionValue.numberOfLines = 0
    }
    
    func setMovieRating(movieRating: String) {
        rating.text = "\(movieRating)/10"
    }
    
    func setMovieLogo(movieLogoURL: String) {
        if let url = URL(string: movieLogoURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.logo.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    func setLikedMovie(isLikedMovie: Bool) {
        isLikedValue = isLikedMovie
        isLiked.setImage(UIImage(systemName: isLikedValue ? "star.fill" : "star"), for: .normal)
        isLiked.configuration?.title = ""
        isLiked.tintColor = .orange
    }
}
