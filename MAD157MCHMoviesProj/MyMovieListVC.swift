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
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: MyMoviesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "customCell2") as! MyMoviesTableViewCell
            
            if (cell == nil ) {
                //cell = UITableViewCell(style: UITableViewCell.CellStyle.default,
                cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,reuseIdentifier: cellID) as! MyMoviesTableViewCell
                }
                
        //        var sortedMovieDictionary8 = self.movieDictionary8.sorted(by: {$0.value.mYear < $1.value.mYear})
        //        print("\nSortedMovieDictionary = \n \(sortedMovieDictionary8)")
               
                
            var key = Array(self.movieDictionary.keys)[indexPath.row]
            var value = Array(self.movieDictionary.values)[indexPath.row]
            
            print("*** key : \(key)")
            print("*** value: \(value)")
                
                //cell.mainText?.text = movieDictionary8.keys[indexPath.row]
        //        cell.mainText?.text = d[indexPath.row]
                
                
            cell.myMovieName?.text = key
            cell.myMovieYear?.text = value
            //cell.imageView?.image = UIImage(named: imageArray[indexPath.row])
            
//            //self.setImage(from: url)
//            let url = value.mPoster
//            print("value of url ==== \(url)")
//            //self.setImage(from: url)
//
//            //var myImage = UIImage(named: imageArray[indexPath.row])
//            var myImage = UIImage(named: defaultImageArray[0])
//
//            if url == "" {
//                //myImage = UIImage(named: imageArray[indexPath.row])
//                myImage = UIImage(named: defaultImageArray[0])
//            } else {
//                let imageURL = URL(string: url)
//                if let imageData = try? Data(contentsOf: imageURL!) {
//
//                    //if (try? Data(contentsOf: imageURL!)) != nil {
//                    myImage = UIImage(data: imageData)
//                    print(myImage)
//                    DispatchQueue.main.async {
//                        //self.detailImage.image = image
//                        //self.imageView?.image = image
//                        //cell.imageView?.image = myImage
//                        return myImage
//                    }
//                } else {
//                    //myImage = UIImage(named: imageArray[indexPath.row])
//                    myImage = UIImage(named: defaultImageArray[0])
//                }
//            }
//         
//            cell.imageView?.image = myImage
           
            return cell
    }
    

}
