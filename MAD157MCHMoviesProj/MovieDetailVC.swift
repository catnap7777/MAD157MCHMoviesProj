//
//  MovieDetailVC.swift
//  MAD157MCHMoviesProj
//
//  Created by Karen Mathes on 9/22/20.
//  Copyright © 2020 TygerMatrix Software. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController {

    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var imdbLabel: UILabel!
    @IBOutlet var detailImage: UIImageView!
    
    //.. used if calling function to set var/lable
    //var testString = "Test String"
    
    var movieTitle = ""
    var movieYear = ""
    var movieType = ""
    var movieIMDB = ""
    var moviePoster = ""
    
    let defaultImageArray = ["posternf.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("in movie detail view controller" )
                // Do any additional setup after loading the view.
                
                //testLabel.text = testString
                movieTitleLabel.text = movieTitle
                yearLabel.text = movieYear
                typeLabel.text = movieType
                imdbLabel.text = movieIMDB
                //posterLabel.text = moviePoster
                
        //        let url = URL(string: "https://static.independent.co.uk/s3fs-public/thumbnails/image/2017/09/12/11/naturo-monkey-selfie.jpg?w968h681")
                let url = moviePoster
                self.detailImage.image = UIImage(named: defaultImageArray[0])
                self.setImage(from: url)
              //  self.imgView.downloadImage(from: url!)
                
            
        //    //.. thought I needed this at first... I don't...
        //    override func viewDidAppear(_ animated: Bool) {
        //
        //        print("oh boy... fun... not...")
        //        testLabel.text = movieTitle
        
    }
    
    
    @IBAction func IMDBButton(_ sender: Any) {
        
        let imdbURL = "https://www.imdb.com/title/" + movieIMDB
        
        if let url = URL(string: imdbURL) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func setMovieDetail(fTitle: String) {

        self.movieTitle = fTitle

        print("you are in setMovieDetail... movieTitle = \(movieTitle)")
        print("fTitle coming in is: \(fTitle)")

        //testLabel.text = movieTitle
        //testLabel.text = "What?????"
        
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else {
                return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.detailImage.image = image
            }
        }
    }
    
    
    
}
