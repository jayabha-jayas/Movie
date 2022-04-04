//
//  DetailsViewController.swift
//  Movie
//
//  Created by Jayabharathi S on 04/04/22.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var movieLabel: UILabel!
    var movieName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        movieLabel.text = movieName
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
