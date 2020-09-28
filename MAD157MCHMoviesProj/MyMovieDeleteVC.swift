//
//  MyMovieDeleteVC.swift
//  MAD157MCHMoviesProj
//
//  Created by Karen Mathes on 9/25/20.
//  Copyright © 2020 TygerMatrix Software. All rights reserved.
//

import UIKit

class MyMovieDeleteVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var myMoviePicker: UIPickerView!
    @IBOutlet var deleteMyMovieButtonObj: UIButton!
    @IBOutlet var myView: UIView!
    
    //.. NOTE: complex dictionary objects (objects with key:tuple - called CFType) cannot be saved in a plist
    //..  This movieDictionary is for the plist
    //var movieDictionary: [String : String] = [:]
    //var moviePickerData: [String] = [String]() //.. string array of movie names
    //var moviePickerData2: [(name: String, year: String, type: String, imdb: String)] = [(name: "", year: "", type: "", imdb: "")]
    
    var myMovieChosen: String = ""
    var myMovieIMDBChosen: String = ""
    var myMovieTypeChosen: String = ""
    var myMovieYearChosen: String = ""
    var myMoviePosterChosen: String = ""
    
    var myPickerTypeIndex = 0
    
    var mymovies = [
        PlistStuff2.MyMovie(name: "", year: "", type: "", imdb: "", poster: "")
    ]

    //.. instantiate plist class
    let myPlist = PlistStuff2()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            
        myMoviePicker.dataSource = self
        myMoviePicker.delegate = self
        
        //moviePickerData2.removeAll()
        mymovies.removeAll()
        
//        //.. make sure correct movie array is built
//        self.moviePickerData.removeAll()
//        for (k,v) in self.movieDictionary {
//            self.moviePickerData.append(k)
//        }
//
//        moviePickerData.sorted(by: <)
//
//        //moviePickerData = moviePickerData.sorted { $0 < $1 }
//
//        //.. try to load existing plist... if it doesn't exist, "save"/create it
//        do {
//            //.. try to load
//            var dictionaryload = try myPlist.loadPropertyList()
//            print("dictionaryloaded is now... \(dictionaryload)")
//            movieDictionary = dictionaryload
//
//            for (k,v) in movieDictionary {
//                moviePickerData.append(k)
//            }
//
//            moviePickerData.sort(by: <)
//
//            print("moviePickerData - \(moviePickerData)")
//
//            } catch {
//                    //.. if not loaded (ie. not found bc it's new), try to save a new one
//                    do {
//                        var dictionaryInitSave = try myPlist.savePropertyList(movieDictionary)
//                        } catch {
//                            print("..tried to save a 'new' plist but it didn't work")
//                        }
//                    print(error)
//                    print(".. tried to load an existing plist but it didn't load or wasn't there")
//            }
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //moviePickerData.removeAll()
        //moviePickerData2.removeAll()
        mymovies.removeAll()
        
        
        
        //.. make sure correct movie array is built
        //.. try to load existing plist... if it doesn't exist, "save"/create it
        do {
            //.. try to load
            let dictionaryload = try myPlist.loadPropertyList()
            //movieDictionary = dictionaryload
            mymovies = dictionaryload
            
//            for item in mymovies {
//                moviePickerData2.append((item.name, item.year, item.type, item.imdb))
//            }
            
            
            
//            for (k,v) in movieDictionary {
//                moviePickerData.append(k)
//            }
            
            //moviePickerData.sort(by: <)
        
            } catch {
                    //.. if not loaded (ie. not found bc it's new), try to save a new one
                    do {
                        var dictionaryInitSave = try myPlist.savePropertyList(mymovies)
                        } catch {
                            print("..tried to save a 'new' plist but it didn't work")
                        }
                    print(error)
                    print(".. tried to load an existing plist but it didn't load or wasn't there")
            }
//        self.moviePickerData.removeAll()
//        for (k,v) in self.movieDictionary {
//            self.moviePickerData.append(k)
//        }
        //moviePickerData2.sort(by: <)
        self.myMoviePicker.reloadAllComponents()
        self.myMoviePicker.reloadComponent(0)
//        self.myMoviePicker.reloadAllComponents()
//        self.myMoviePicker.reloadComponent(0)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mymovies.count
//        return moviePickerData2.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        
        myMovieChosen = mymovies[0].name
        myMovieYearChosen = mymovies[0].year
        myMovieTypeChosen = mymovies[0].type
        myMovieIMDBChosen = mymovies[0].imdb
            
        pickerLabel.text = mymovies[row].name
        print("pickerlabel \(pickerLabel.text) - \(mymovies[row].name)")
//        pickerLabel.text = moviePickerData2[row].name
//        print("pickerlabel \(pickerLabel.text) - \(moviePickerData2[row].name)")
            
        if UIDevice.current.userInterfaceIdiom == .pad {
            pickerLabel.font = UIFont.systemFont(ofSize: 18)
            //pickerLabel.text = "Row \(row)"  //.. not needed bc set above
        } else if UIDevice.current.userInterfaceIdiom == .phone {
            pickerLabel.font = UIFont.systemFont(ofSize: 18)
//            pickerLabel.font = UIFont.systemFont(ofSize: 14)
            //pickerLabel.text = "Row \(row)"  //.. not needed bc set above
        }
        
        return pickerLabel
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let pickerTypeIndex = myMoviePicker.selectedRow(inComponent: 0)
        //myPickerTypeIndex = pickerTypeIndex
        
        myMovieChosen = mymovies[pickerTypeIndex].name
        myMovieYearChosen = mymovies[pickerTypeIndex].year
        myMovieTypeChosen = mymovies[pickerTypeIndex].type
        myMovieIMDBChosen = mymovies[pickerTypeIndex].imdb
//        myMovieChosen = moviePickerData2[pickerTypeIndex].name
//        myMovieYearChosen = moviePickerData2[pickerTypeIndex].year
//        myMovieTypeChosen = moviePickerData2[pickerTypeIndex].type
//        myMovieIMDBChosen = moviePickerData2[pickerTypeIndex].imdb
        
        //print("myMovieChosen = \(myMovieChosen)")
    }

    
    @IBAction func deleteMyMoviePressed(_ sender: Any) {
        
    let msg = "Are you sure you want to delete... \n- Movie: \(myMovieChosen) \n- Year:\(myMovieYearChosen) \n- Type:\(myMovieTypeChosen) \n- Imdb:\(myMovieIMDBChosen)???"
        
    let alert = UIAlertController(title: "Confirm", message: msg, preferredStyle: .alert)
//
//     let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this movie?? - \(myMovieChosen) - \n\(myMovieYearChosen) - \(myMovieTypeChosen) - \n\(myMovieIMDBChosen)", preferredStyle: .alert)
        
    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { action -> Void in
        //Just dismiss the action sheet
        })
        
    let okAction = UIAlertAction(title: "Delete", style: .default, handler: { action -> Void in
        
        //.. remove the key
        print("movie to delete = \(self.myMovieChosen)  \(self.myMovieIMDBChosen)")
        //self.movieDictionary.removeValue(forKey: self.myMovieChosen)
        //*************************************
        self.mymovies.remove(at: self.myPickerTypeIndex)
        
        //self.mymovies[indexPath.row].year = ("\(savedYear) - \(savedText2)")
        
        //.. save the plist
        do {
            try self.myPlist.savePropertyList(self.mymovies)
            //.. make sure correct movie array is built
            
//            self.moviePickerData2.removeAll()
//            for item in self.mymovies {
//                self.moviePickerData2.append((item.name, item.year, item.type, item.imdb))
//            }
            
            //self.moviePickerData2.remove(at: self.myPickerTypeIndex)
            //**** sort may actually be the problem
            //self.moviePickerData2.sort(by: <)
            self.myMoviePicker.reloadAllComponents()
            self.myMoviePicker.reloadComponent(0)
            self.myView.reloadInputViews()
        } catch {
            print("..not able to resave plist after attempted delete..")
        }
        
    })
        
    alert.addAction(okAction)
    alert.addAction(cancelAction)
    self .present(alert, animated: true, completion: nil )
        
    }
    

}
