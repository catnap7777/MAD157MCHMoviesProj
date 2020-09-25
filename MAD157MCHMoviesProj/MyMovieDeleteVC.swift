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
    
    var movieDictionary: [String : String] = [:]
    
    var moviePickerData: [String] = [String]()
    
    var myMovieChosen: String = ""

    //.. instantiate class
    let myPlist = PlistStuff()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            
        myMoviePicker.dataSource = self
        myMoviePicker.delegate = self
        
        //.. empty moviePickerData
        moviePickerData.removeAll()
        
        //.. try to load existing plist... if it doesn't exist, "save"/create it
        do {
            //.. try to load
            var dictionaryload = try myPlist.loadPropertyList()
            print("dictionaryloaded is now... \(dictionaryload)")
            movieDictionary = dictionaryload
            
            for (k,v) in movieDictionary {
                moviePickerData.append(k)
            }
            
            moviePickerData.sort(by: <)
            
            print("moviePickerData - \(moviePickerData)")
        
            } catch {
                    //.. if not loaded (ie. not found bc it's new), try to save a new one
                    do {
                        var dictionaryInitSave = try myPlist.savePropertyList(movieDictionary)
                        } catch {
                            print("..tried to save a 'new' plist but it didn't work")
                        }
                    print(error)
                    print(".. tried to load an existing plist but it didn't load or wasn't there")
            }
    
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return movieDictionary.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
            
        pickerLabel.text = moviePickerData[row]
        print("pickerlabel \(pickerLabel.text) - \(moviePickerData[row])")
            
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
        
        myMovieChosen = moviePickerData[pickerTypeIndex]
        print("myMovieChosen = \(myMovieChosen)")
    }

    
    @IBAction func deleteMyMoviePressed(_ sender: Any) {
        
    let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this movie??", preferredStyle: .alert)
        
    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { action -> Void in
        //Just dismiss the action sheet
        })
        
    let okAction = UIAlertAction(title: "Delete", style: .default, handler: { action -> Void in
        
        //.. remove the key
        print("movie to delete = \(self.myMovieChosen)")
        self.movieDictionary.removeValue(forKey: self.myMovieChosen)
        //.. save the plist
        do {
            try self.myPlist.savePropertyList(self.movieDictionary)
            self.myMoviePicker.reloadAllComponents()
            self.myMoviePicker.reloadComponent(0)
        } catch {
            print("..not able to resave plist..")
        }
        
    })
        
    alert.addAction(cancelAction)
    alert.addAction(okAction)
    self .present(alert, animated: true, completion: nil )
        
    }
    

}
