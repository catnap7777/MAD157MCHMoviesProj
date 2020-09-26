//
//  MyMovieListVC.swift
//  MAD157MCHMoviesProj
//
//  Created by Karen Mathes on 9/25/20.
//  Copyright © 2020 TygerMatrix Software. All rights reserved.
//

import UIKit

class MyMovieListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var myMoviesTableViewObj: UITableView!
   
    //.. NOTE: complex dictionary objects (objects with key:tuple - called CFType) cannot be saved in a plist
    var movieDictionary: [String : String] = [:]
    
    let cellID = "cellID"
    
    
    //.. instantiate class
    let myPlist = PlistStuff()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        
        myMoviesTableViewObj.dataSource = self
        myMoviesTableViewObj.delegate = self
        
        //.. try to load existing plist... if it doesn't exist, "save"/create it
        do {
            //.. try to load
            var dictionaryload = try myPlist.loadPropertyList()
            print("dictionaryloaded is now... \(dictionaryload)")
            movieDictionary = dictionaryload
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        //.. try to load existing plist... if it doesn't exist, "save"/create it
        do {
            //.. try to load
            var dictionaryload2 = try myPlist.loadPropertyList()
            print("dictionaryloaded is now... \(dictionaryload2)")
            movieDictionary = dictionaryload2
        
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
        self.myMoviesTableViewObj.reloadData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: MyMoviesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "customCell2") as! MyMoviesTableViewCell
            
            if (cell == nil ) {
                //cell = UITableViewCell(style: UITableViewCell.CellStyle.default,
                cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,reuseIdentifier: cellID) as! MyMoviesTableViewCell
                }
                
            var key = Array(self.movieDictionary.keys)[indexPath.row]
            var value = Array(self.movieDictionary.values)[indexPath.row]
            
            print("*** key : \(key)")
            print("*** value: \(value)")
                
            cell.myMovieName?.text = key
            cell.myMovieYear?.text = value
            
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")

            //let selectedItem = movieArray8[indexPath.row]
        
        var movieKeySelected = Array(self.movieDictionary.keys)[indexPath.row]
        var movieValueSelected = Array(self.movieDictionary.values)[indexPath.row]
            
       //.. The first line creates an alert controller that displays the title “Log In” and underneath the message “Enter Password”

       let alert = UIAlertController(title: "Your Choice", message: "\(movieKeySelected)", preferredStyle: .alert)

       //.. because we want to display a text field on the alert controller, the alert controller’s preferredStyle must be .alert

       alert.addTextField(configurationHandler: {(textField) in                textField.placeholder = "Your Comments here..."
           //textField.isSecureTextEntry = true
       })

        //.. defines Cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { action -> Void in
                //Just dismiss the action sheet
        })
    
       //.. defines OK button
       let okAction = UIAlertAction(title: "OK", style: .default, handler: { action -> Void in

               //.. called savedText, which represents the first text field (note the index value of 0) on the alert controller. If you add more than one text field to an alert controller, you’ll need to define additional constants to represent those other text fields

                let savedText = alert.textFields![0] as UITextField
                let savedText2: String  = savedText.text ?? ""
            
                let savedYear = String(movieValueSelected.prefix(4))
            
                print("new comments = \(savedText)")
            
                //.. attempt to save the new data to plist
                //.. add the new movie
                self.movieDictionary.updateValue("\(savedYear) - \(savedText2)", forKey: movieKeySelected)
                print("movieDictionary now with comments = \(self.movieDictionary)")
                //.. save the plist
                do {
                    try self.myPlist.savePropertyList(self.movieDictionary)
                    self.myMoviesTableViewObj.reloadData()
                } catch {
                    print("no way... not happening...")
                }

           })

               //..adds the button to the alert controller and next line presents or displays the alert controller
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                self.present(alert, animated: true , completion: nil)

        }
    

}
