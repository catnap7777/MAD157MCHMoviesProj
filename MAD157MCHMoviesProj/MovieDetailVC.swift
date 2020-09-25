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
    
//    let dictionary = ["key1" : "value1", "key2":"value2", "key3":"value3"]
//    var movieDictionary: [String : (movieTitle: String, movieYear: String, movieType: String, moviePoster: String)] = [:]
//    var movieDictionary: [String : (movieYear: String, movieType: String)] = [:]
    var movieDictionary: [String : String] = [:]
    
    
    
    let myPlist = PlistStuff()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //.. create plist if it doesn't already exist
        //..
        //.. can't use CFType (tuple)
//        movieDictionary = ["movie1" : (movieYear: "2020", movieType: "movie")]
//        movieDictionary = ["movie2" : (movieYear: "2020", movieType: "movie2")]
        
        movieDictionary = ["movie1" : "2020"]
        
//        //.. create plist if it doesn't exist already
//        do {
//            var dictionaryInit = try myPlist.savePropertyList(movieDictionary)
//                    //var dictionary2 = try myPlist.loadPropertyList()
//                    //***movieDictionary = try myPlist.loadPropertyList()
//                    //***print("movieDictionary before update (loaded): \(movieDictionary)")
//        //            dictionary2.updateValue("xxxxxxvalue4", forKey: "key3")
//        //            dictionary2.updateValue("2033", forKey: "movie2")
//        //            dictionary2.updateValue("year4", forKey: "movie4")
//        //            dictionary2.updateValue("year5", forKey: "movie5")
//                    //dictionary2.updateValue(movieType, forKey: movieTitle)
//                    //***movieDictionary[movieTitle] = movieType
//                    //***print("movieDictionary after new movie added \(movieDictionary)")
//        //            dictionary2.removeAll()
//
//            //try myPlist.savePropertyList(dictionaryInit)
//                    //***try myPlist.savePropertyList(movieDictionary)
//                    //***print("movieDictionary after save - \(movieDictionary)")
//                } catch {
//                    print(error)
//                    print("nope... did NOT update plist... why not?")
//                }
        
        print("movieDictionary = \(movieDictionary)")
        
        do {
                    var dictionaryload = try myPlist.loadPropertyList()
                    //..remove bogus initial keey
           //*******         dictionaryload.removeValue(forKey: "movie1")
            
                    //dictionary2.updateValue("aaaaaaaa", forKey: "key3")
                    //dictionary2.removeValue(forKey: "key2")
                    //dictionary2.removeAll()
            
//                    //.. remove bogus key
//                    dictionaryload.removeValue(forKey: "movie1")
            
                    //.. to clean out dictionary
                    //..dictionaryload.removeAll()
        
                    print("dictionaryloaded is now... \(dictionaryload)")
        
                    //.. to save clean dictionary
                    //..try myPlist.savePropertyList(dictionaryload)
                } catch {
                    print(error)
                    print("plist did not load")
                }
        
//        do {
//            //let dictionary = ["key1" : "value1", "key2":"value2", "key3":"value3"]
//            //try myPlist.savePropertyList(dictionary)
//            try myPlist.savePropertyList(movieDictionary)
//        } catch {
//            print(error)
//            print("maybe plist already exists?")
//        }
        
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
    
    @IBAction func saveMyMovieButtonPressed(_ sender: Any) {
        
//        do {
//            let dictionary = ["key1" : "value1", "key2":"value2", "key3":"value3"]
//            try myPlist.savePropertyList(dictionary)
//        } catch {
//            print(error)
//        }
        
        print("aren't you going to do the other part???")
        //updatePlist()
        
        do {
            var dictionary2 = try myPlist.loadPropertyList()
            //***movieDictionary = try myPlist.loadPropertyList()
            //***print("movieDictionary before update (loaded): \(movieDictionary)")
//            dictionary2.updateValue("xxxxxxvalue4", forKey: "key3")
//            dictionary2.updateValue("2033", forKey: "movie2")
//            dictionary2.updateValue("year4", forKey: "movie4")
//            dictionary2.updateValue("year5", forKey: "movie5")
            
            //.. remove bogus key
            dictionary2.removeValue(forKey: "movie1")
            dictionary2.updateValue(movieType, forKey: movieTitle)
            //***movieDictionary[movieTitle] = movieType
            //***print("movieDictionary after new movie added \(movieDictionary)")
//            dictionary2.removeAll()
            try myPlist.savePropertyList(dictionary2)
            //***try myPlist.savePropertyList(movieDictionary)
            //***print("movieDictionary after save - \(movieDictionary)")
        } catch {
            print(error)
            print("nope... did NOT update plist... why not?")
        }
    }
    
//    func updatePlist() {
//        do {
//            var dictionary2 = try myPlist.loadPropertyList()
//            //dictionary2.updateValue("aaaaaaaa", forKey: "key3")
//            //dictionary2.removeValue(forKey: "key2")
//            //dictionary2.removeAll()
//
//            print("dictionary2 is now... \(dictionary2)")
//
//
//            try myPlist.savePropertyList(dictionary2)
//        } catch {
//            print(error)
//            print("what the hell is going on?")
//        }
//    }
    
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
