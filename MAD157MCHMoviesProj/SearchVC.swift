//
//  SearchVC.swift
//  MAD157MCHMoviesProj
//
//  Created by Karen Mathes on 9/22/20.
//  Copyright © 2020 TygerMatrix Software. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    var movieArray7: [String] = []
    
    var movieArrayTup: [(xName: String, xYear: String, xType: String, xIMDB: String, xPoster: String)] = [("","","","","")]
    
    var movieDictionary7: [String : (mYear: String, mType: String, mIMDB: String, mPoster: String)] = [:]
    
    var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    //        The first line defines the view as an observer to receive the keyboardWillShowNotification. When this notification appears, then the app needs to run a function called keyboardWillShow. The second line defines the view as an observer to receive the keyboardWillHideNotification. When this notification appears, then the app needs to run a function called keyboardWillHide.
            
            NotificationCenter.default.addObserver( self , selector: #selector (keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil )
            
            NotificationCenter.default.addObserver( self , selector: #selector (keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil )
            
    //        This code allows the view to detect tap gestures (when the user taps outside of a text field). When this occurs, this line runs a function called dismissKeyboard .
            
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self , action: #selector (self.dismissKeyboard))
            view.addGestureRecognizer(tap)
            
//            searchTextField.placeholder = "Email address here"
//            searchTextField.textColor = UIColor.red
//            searchTextField.font = UIFont(name: "Courier", size: 16)
//            //.. gets rid of the little "clear" x in the right side corner of the text box
//            searchTextField.clearButtonMode = .whileEditing
                
    }
    
    //    This function runs when the user taps outside of a text field, which ends editing and sends the notification that the virtual keyboard needs to go away (keyboardWillHideNotification).
       
        @objc func dismissKeyboard() {
            view.endEditing( true )
        }
        
    //    This function defines the keyboard size based on the size of the iOS screen. (Remember, iPhone screens are narrower than iPad screens.) Then this function uses the height of the virtual keyboard to determine how far to slide the view (along with all its user interface objects) up to make room for the virtual keyboard.

        @objc func keyboardWillShow(notification: NSNotification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self .view.frame.origin.y == 0 {
                    self .view.frame.origin.y -= keyboardSize.height
               }
            }
        }
        
    //    This function checks if the virtual keyboard is visible. If not, then do nothing. If the virtual keyboard is visible, then move the view back down to cover and hide the virtual keyboard

        @objc func keyboardWillHide(notification: NSNotification) {
            if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
                if self .view.frame.origin.y != 0 {
                    self .view.frame.origin.y = 0
                }
            }
        }

       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            var vc = segue.destination as! MovieListVC
            
            vc.finalName = self.searchText
            //vc.movieList = self.movieArray7
    //        print("movieArray7 going out: \(movieArray7)")
    //        vc.kamSetArray(movieArray: movieArray7)
            
            var sortedMovieDictionary7 = movieDictionary7.sorted(by: {$0.value.mYear < $1.value.mYear})
            
            print("!@##$^!%#^!#%^!#% --- movieDictionary going out... count = \(movieDictionary7.count) :\n \(movieDictionary7)")
            
        //**********
            for (k2,v2) in sortedMovieDictionary7 {
                print("\n key/value pair in movieDictionary7 ::: \(k2) --> \(v2.mYear)")
            }
            
            vc.kamSetDictionary(movieDictionary: movieDictionary7)
            //vc.kamSetDictionary(movieDictionary: sortedMovieDictionary7)
            
    //        print("sortedMovieDictionary going out... count = \(sortedMovieDictionary7.count) :\n \(sortedMovieDictionary7)")
    //        vc.kamSetDictionary(movieDictionary: sortedMovieDictionary7)
        
        //.. array stuff
        //myArray.sort{ $0.1 != $1.1 ? $0.1 > $1.1 : $0.0 < $1.0 }
        //let movieArrayTupSorted: [(String, String, String, String, String)] =
//        let movieArrayTupSorted: () = movieArrayTup.sort{ $0.1 != $1.1 ? $0.1 > $1.1 : $0.0 < $1.0 }
        
        let movieArrayTupSorted = movieArrayTup.sorted { $0.1 > $1.1 }
       
       
        print("$$$$$$$$$ movieArrayTup = \(movieArrayTup)")
        print("$$$$$$$$$ movieArrayTupSorted = \(movieArrayTupSorted)")
        
        vc.movieArrayTupSorted2 = movieArrayTupSorted
            
            
        }

    @IBAction func searchMovieButtonPressed(_ sender:  UIButton) {
        
        print("hi kar. button pressed.")
        
//        searchButton.setTitle("searchButton Clicked", for: UIControl.State.normal)
//        searchButton.backgroundColor = UIColor.gray
//        searchButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
                
        self.searchText = searchTextField.text ?? ""
                
        //        print("****** this is what you have in the text box when searchButton is clicked: \(searchText)")
        //
        var p = queryJSON(query: searchText )
                
        //        print("\nvariable p = \(p)")
        //        print("\nhi karen... searchButton was clicked")
                //.. this worked!
                //movieArray7[0] = "THIS IS A TEST"
                
            }

            
            //..
            //  http://www.omdbapi.com?apikey=1b6ca2da&s=contact //Where and how to hide apikey?
            let apiKey = "1b6ca2da"

            //.. Movie JSON example from API
            //{"Search":[{"Title":"Contact","Year":"1997","imdbID":"tt0118884","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BYWNkYmFiZjUtYmI3Ni00NzIwLTkxZjktN2ZkMjdhMzlkMDc3XkEyXkFqcGdeQXVyNDk3NzU2MTQ@._V1_SX300.jpg"},{"Title":"Star Trek: First Contact","Year":"1996","imdbID":"tt0117731","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BYTllZjRkY2QtYTJlMy00ZTMxLWE0YWQtMWMwYzY2YTM3YzRjXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_SX300.jpg"},{"Title":"Full Contact","Year":"1992","imdbID":"tt0105851","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BMTczNDUwOTU3M15BMl5BanBnXkFtZTgwNTY3NTkwMzE@._V1_SX300.jpg"},


            struct Search: Codable {
                
                let title: String
                let year: String
                let imdbID: String
                let type: String
                let posterUrl: String
                
                private enum CodingKeys: String, CodingKey {
                    case title = "Title"        //..map JSON "Title" to new name title
                    case year = "Year"          //..map JSON "Year" to new name year
                    case imdbID                 //..JSON name is imdbID; so, no change
                    case type = "Type"          //..map JSON "Type" to new name type
                    case posterUrl = "Poster"   //..map JSON "Poster" to new name poster
                }
            }

            struct Movie: Codable {
                
                let search: [Search]    //..maps to Search Structure above
                
                private enum CodingKeys: String, CodingKey {
                    case search = "Search"       //..map JSON "Search" to new name search
                    
                }
                
            }
            
            //..................................................................................................................................
            
            //.. to query movie api
            func queryJSON(query: String) {
              
                self.movieArray7.removeAll()
                self.movieDictionary7.removeAll()
                self.movieArrayTup.removeAll()
               
                //print("\n******* movieArray7 before task = \n\(movieArray7.count)")
                
                //..build the url for going out to movie api to get JSON data
                
                var components = URLComponents()
                components.scheme = "https"
                components.host = "www.omdbapi.com"
                components.queryItems = [
                    URLQueryItem(name: "apikey", value: apiKey),
                    URLQueryItem(name: "s", value: query)//,
                ]
                
                let url = components.url
                //.. another good example to play around with
                //let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
                //***********************************************************************************************************
                //.. from https://stackoverflow.com/questions/48130993/swift-4-jsonserialization-jsonobject
                //..
                //let task = URLSession.shared.dataTask(with: url.getURL()) { data, _, error in
                
                let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                    
                    guard let data = data, error == nil else {
                        print(error ?? "Unknown error")
                        return
                    }
                    
                    //.. prints url data - useful to see movie api string built
        //            let myResponse = response
        //            print("\nMy Url Response = \(String(describing: myResponse))")
                    
                    var h = 0
                    
                    let decoder = JSONDecoder()
                    do {
                        let responseObject = try decoder.decode(Movie.self, from: data)
                        
                        for item in responseObject.search {
                            
                            let t = item.title
                            let y = item.year
                            let typ = item.type
                            let p = item.posterUrl
                            let i = item.imdbID
                       
                            //self.movieArray4.append([t, y, typ, i, p])
                            self.movieArray7.append(t)
                            self.movieArrayTup.append((xName: t, xYear: y, xType: typ, xIMDB: i, xPoster: p))
                            
                            self.movieDictionary7[t] = (mYear: y, mType: typ, mIMDB: i, mPoster: p)
                           
                            //print("movie = \(t)")
                            
                            h += 1
                        }
                        
                        print("\n$$$$$$$$%%%%%%%%%%######### movieArray7 with appended data: count = \(self.movieArray7.count)")
                       
                        
                        print("\n\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                        print("\nThis (below) is what the movieArray looks like at the time of this \"call\"...\nNumber of JSON movies found for query: \(query) is: \(h)\n")
                        
                        print("**** \n movieArray7 = \n\(self.movieArray7)")
                        
                    } catch {
                        print("Uh oh, that didn't work :(")
                        print(error)
                    }
                    
                    // if you then need to update UI or model objects, dispatch that back
                    // to the main queue:
                    DispatchQueue.main.async {
                        // use `responseObject.data` to update model objects and/or UI here
                        
                        print("\nIn DispatchQueue -> .....)\n")
                        
                        
                    
                        self.searchTextField.text = ""
                        self.searchButton.setTitle("Search", for: UIControl.State.normal)
                        self.searchButton.backgroundColor = UIColor.yellow
                        self.searchButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
                        
                        self.performSegue(withIdentifier: "moviesSegue", sender: self)
                        
                    }
                    
                    
                } //.. end of closure
                
                task.resume()
                
            }

        
}

