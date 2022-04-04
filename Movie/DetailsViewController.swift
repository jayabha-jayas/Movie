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
    var movieName: String?
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
        isLikeButton.setImage(UIImage(systemName: isLiked! ? "star.fill" : "star"), for: .normal)
    }
}
