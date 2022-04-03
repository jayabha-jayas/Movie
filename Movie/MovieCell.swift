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
    @IBOutlet var logo: UIImageView!
    
    func setContent(movie : Movie) {
        name.text = movie.name
        name.numberOfLines = 0
        descriptionValue.text = movie.description
        descriptionValue.numberOfLines = 0
        rating.text = String(movie.rating)
        
        if let url = URL(string: movie.logo) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.logo.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
