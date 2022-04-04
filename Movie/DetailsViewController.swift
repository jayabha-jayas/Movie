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
    @IBOutlet weak var movieDescription: UILabel!
    var movieName: String?
    var movieDescriptionValue: String?
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
        isLikeButton.setImage(UIImage(systemName: isLiked! ? "star.fill" : "star"), for: .normal)
        isLikeButton.configuration?.title = ""
    }
}
