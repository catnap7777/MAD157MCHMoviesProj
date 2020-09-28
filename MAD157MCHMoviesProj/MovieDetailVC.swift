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
    
    //.. NOTE: complex dictionary objects (objects with key:tuple - called CFType) cannot be saved in a plist
    //..  This movieDictionary is for the plist
    //var movieDictionary: [String : String] = [:]
    var mymovies = [
        PlistStuff2.MyMovie(name: "", year: "", type: "", imdb: "", poster: "")
    ]
    
    //.. instantiate plist class
    let myPlist = PlistStuff2()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        movieDictionary = ["movie1" : "2020"]
//
//        //.. try to load existing plist... if it doesn't exist, "save"/create it
//        do {
//            //.. try to load
//            mymovies.removeAll()
//            mymovies = try myPlist.loadPropertyList()
//            print("$$$ MovieDetailVC - mymovies plist load attempt - \(mymovies)")
//            } catch {
//                    //.. if not loaded (ie. not found bc it's new), try to save a new one
//                    do {
//                        var dictionaryInitSave = try myPlist.savePropertyList(mymovies)
//                        print("$$$ MovieDetailVC - mymovies plist save attempt - \(mymovies)")
//                    }
//                        catch {
//                            print("$$$ MovieDetailVC ..tried to save a 'new' plist but it didn't work")
//                    }
//                    print(error)
//                    print("$$$ MovieDetailVC.. tried to load an existing plist but it didn't load or wasn't there")
//                }
        
        mymovies.removeAll()
        
        //testLabel.text = testString
        movieTitleLabel.text = movieTitle
        yearLabel.text = movieYear
        typeLabel.text = movieType
        imdbLabel.text = movieIMDB
        //posterLabel.text = moviePoster
                
        //        let url = URL(string: "https://static.independent.co.uk/s3fs-public/thumbnails/image/2017/09/12/11/naturo-monkey-selfie.jpg?w968h681")
        
        //.. value of which was already set from MovieListVC when row was clicked on and segue performed
        let url = moviePoster
        self.detailImage.image = UIImage(named: defaultImageArray[0])
        //.. takes the movie url from moviePoster and call func setImage to place picture on screen
        self.setImage(from: url)
        //  self.imgView.downloadImage(from: url!)
                
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
    
    @IBAction func IMDBButton(_ sender: Any) {
        
        let imdbURL = "https://www.imdb.com/title/" + movieIMDB
        
        if let url = URL(string: imdbURL) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func saveMyMovieButtonPressed(_ sender: Any) {
        
        print("348124723947 You're in saveMyMovieButtonPressed")
        do {
            
            mymovies = try myPlist.loadPropertyList()
            print("48104127423047 You loaded the plist... mymovies = \(mymovies)")
            } catch {
                print(error)
                print("$$$ MovieDetailVC.. nope... did NOT save/update plist with 'new' movie... why not?")
            }
        
        for item in mymovies {
            print("$$$#$)*$)!#*)(#%&#&% my item = \(item)")
        }
        
        //******** this works
        mymovies.append(PlistStuff2.MyMovie(name: movieTitle, year: movieYear, type: movieType, imdb: movieIMDB, poster: moviePoster))
        
//        var x = mymovies(PlistStuff2.MyMovie(name: <#T##String#>, year: <#T##String#>, type: <#T##String#>, imdb: <#T##String#>, poster: <#T##String#>))
        
        //.. save the plist
        do {
            try myPlist.savePropertyList(mymovies)
            print("$$$ MovieDetailVC - mymovies plist save attempt - \(mymovies)")
            //.. if it saved, show an alert
            let alert2 = UIAlertController(title: "Message", message: "Movie Saved to My Movies :)", preferredStyle: .alert)
            let okAction2 = UIAlertAction(title: "OK", style: .default, handler: { action -> Void in
                //Just dismiss the action sheet
                })
            alert2.addAction(okAction2)
            self.present(alert2, animated: true, completion: nil )

        } catch {
             print("$$$ MovieDetailVC ..tried to save plist but it didn't work")
            print("$$$ MovieDetailVC - mymovies plist save attempt - \(mymovies)")
        }
        //*************
            //.. examples of other things you can do
//            dictionary2.updateValue("xxxxxxvalue4", forKey: "key3")
//            dictionary2.updateValue("2033", forKey: "movie2")
//            dictionary2.updateValue("year4", forKey: "movie4")
//            dictionary2.updateValue("year5", forKey: "movie5")
//            dictionary2.removeAll()
            //.. remove bogus key that was initially added if new plist created in viewDidLoad
            //dictionary2.removeValue(forKey: "movie1")
            //.. add the new movie
            //dictionary2.updateValue(movieYear, forKey: movieTitle)
            
            //.. want to save "new" movie if it doesn't already exist (name/year/type)
            print("...... mymovies = \(mymovies)")
//            for item in mymovies {
//                print("...inside the for loop --- item = \(item)")
        
            
//                    print("^^^^^^^ duplicate movie....... --- item.imdb = \(item.imdb)  movieIMDB = \(movieIMDB)")
//                    //.. movie already in mymovies - so do nothing
//                    //.. if it did not save, show an alert
//                    let alert1 = UIAlertController(title: "Message", message: "Movie Already Exists in My Movies", preferredStyle: .alert)
//                    let okAction1 = UIAlertAction(title: "OK", style: .default, handler: { action -> Void in
//                        //Just dismiss the action sheet
//                        })
//                    alert1.addAction(okAction1)
//                    self.present(alert1, animated: true, completion: nil )
//                } else {
//                    print("^^^^^^^ insert movie........")
//                    //.. insert new movie
//                    mymovies.append(PlistStuff2.MyMovie(name: movieTitle, year: movieYear, type: movieType, imdb: movieIMDB, poster: moviePoster))
//                    //.. save the plist
//                    do {
//                        try myPlist.savePropertyList(mymovies)
//                        print("$$$ MovieDetailVC - mymovies plist save attempt - \(mymovies)")
//                    } catch {
//                         print("$$$ MovieDetailVC ..tried to save plist but it didn't work")
//                        print("$$$ MovieDetailVC - mymovies plist save attempt - \(mymovies)")
//                    }
//                    //.. if it saved, show an alert
//                    let alert2 = UIAlertController(title: "Message", message: "Movie Saved to My Movies :)", preferredStyle: .alert)
//                    let okAction2 = UIAlertAction(title: "OK", style: .default, handler: { action -> Void in
//                        //Just dismiss the action sheet
//                        })
//                    alert2.addAction(okAction2)
//                    self.present(alert2, animated: true, completion: nil )
//
//                }
////            }
//
//        } catch {
//            print(error)
//            print("$$$ MovieDetailVC.. nope... did NOT save/update plist with 'new' movie... why not?")
//        }
    }
             
            
            //}
            
            
//            mymovies.append(PlistStuff2.MyMovie(name: movieTitle, year: movieYear, type: movieType, imdb: movieIMDB, poster: moviePoster))
//            //.. save the plist
//            do {
//                try myPlist.savePropertyList(mymovies)
//                print("$$$ MovieDetailVC - mymovies plist save attempt - \(mymovies)")
//            } catch {
//                 print("$$$ MovieDetailVC ..tried to save plist but it didn't work")
//                print("$$$ MovieDetailVC - mymovies plist save attempt - \(mymovies)")
//            }
//            //.. if it saved, show an alert
//            let alert = UIAlertController(title: "Message", message: "Movie Saved to My Movies :)", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: { action -> Void in
//                //Just dismiss the action sheet
//                })
//            alert.addAction(okAction)
//            self.present(alert, animated: true, completion: nil )
//
//            } catch {
//                print(error)
//                print("$$$ MovieDetailVC.. nope... did NOT save/update plist with 'new' movie... why not?")
//            }
    //}
 
    
    
    
}
