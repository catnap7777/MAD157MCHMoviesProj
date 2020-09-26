//
//  MovieListVC.swift
//  MAD157MCHMoviesProj
//
//  Created by Karen Mathes on 9/22/20.
//  Copyright © 2020 TygerMatrix Software. All rights reserved.
//

import UIKit

class MovieListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var movieTable: UITableView!
    @IBOutlet var labelName: UILabel!
    
    var finalName = ""
    
    var selectedToPass = "a"
    
    var movieArray8 = ["movieArray8 first value"]
    
    var movieArrayTupSorted2: [(xName: String, xYear: String, xType: String, xIMDB: String, xPoster: String)] = [("","","","","")]
    
    var movieDictionary8: [String : (mYear: String, mType: String, mIMDB: String, mPoster: String)] = [:]
    
    let imageArray = ["hp.jpg",
                      "hp.jpg",
                      "hp.jpg",
                      "hp.jpg",
                      "hp.jpg",
                      "hp.jpg",
                      "hp.jpg",
                      "hp.jpg",
                      "hp.jpg",
                      "hp.jpg",
                      "hp.jpg",
                      "hp.jpg",
                      "hp.jpg"
    ]
    
    let defaultImageArray = ["posternf.png","pearl.jpg","gitcat.jpg"]
    
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        movieTable.dataSource = self
        movieTable.delegate = self
        
        finalName = finalName.uppercased()
        labelName.text = "\"" + finalName + "\"" + " Movies"
        
        print("&&&&&& movieArrayTupSorted2 = \(movieArrayTupSorted2)")
        
        //.. from https://www.raywenderlich.com/8549-self-sizing-table-view-cells
//        movieTable.rowHeight = UITableView.automaticDimension
//        movieTable.estimatedRowHeight = 900
            
    }
    
    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            //return movieDictionary8.count
            return movieArrayTupSorted2.count
        }
        
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        //var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        var cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! TableViewCell
        
        if (cell == nil ) {
            //cell = UITableViewCell(style: UITableViewCell.CellStyle.default,
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,reuseIdentifier: cellID) as! TableViewCell
            }
            
    //        var sortedMovieDictionary8 = self.movieDictionary8.sorted(by: {$0.value.mYear < $1.value.mYear})
    //        print("\nSortedMovieDictionary = \n \(sortedMovieDictionary8)")
           
        var mRow = movieArrayTupSorted2[indexPath.row]
            
        var key = Array(self.movieDictionary8.keys)[indexPath.row]
        var value = Array(self.movieDictionary8.values)[indexPath.row]
        
        print("*** key : \(key)")
        print("*** value: \(value)")
        
        print("*** mRow: \(mRow)")
            
            //cell.mainText?.text = movieDictionary8.keys[indexPath.row]
    //        cell.mainText?.text = d[indexPath.row]
            
        cell.mainText?.text = mRow.xName
        cell.subText?.text = mRow.xYear
        
//        cell.mainText?.text = key
//        cell.subText?.text = value.mYear
        //cell.imageView?.image = UIImage(named: imageArray[indexPath.row])
        
        //self.setImage(from: url)
        //let url = value.mPoster
        let url = mRow.xPoster
        print("value of url ==== \(url)")
        //self.setImage(from: url)
        
        //var myImage = UIImage(named: imageArray[indexPath.row])
        var myImage = UIImage(named: defaultImageArray[0])
        
        if url == "" {
            //myImage = UIImage(named: imageArray[indexPath.row])
            myImage = UIImage(named: defaultImageArray[0])
        } else {
            let imageURL = URL(string: url)
            if let imageData = try? Data(contentsOf: imageURL!) {
                
                //if (try? Data(contentsOf: imageURL!)) != nil {
                myImage = UIImage(data: imageData)
                print(myImage)
                DispatchQueue.main.async {
                    //self.detailImage.image = image
                    //self.imageView?.image = image
                    //cell.imageView?.image = myImage
                    return myImage
                }
            } else {
                //myImage = UIImage(named: imageArray[indexPath.row])
                myImage = UIImage(named: defaultImageArray[0])
            }
        }
     
        cell.imageView?.image = myImage
       
        return cell
    }
        
        // method to run when table view cell is tapped
        //.. NOTE:  Per "bug" where MovieDetailVC2 VC apparently loads twice per stackoverflow
        //..   https://stackoverflow.com/questions/1081131/viewdidload-getting-called-twice-on-rootviewcontroller-at-launch
        //.. 2020 - see this for solution and why it's happening!!!!!!!
        //.. https://stackoverflow.com/questions/32300300/view-controller-loads-twice-how-do-i-fix-it#:~:text=Here's%20the%20simplest%20solution%20ever,and%20you%20should%20be%20okay.
    
        //..   post about viewDidLoad from segue call from MovieListViewController, I had
        //..   to rename MovieDetailVC to MovieDetailVC2 and redo the segue
        //..   to stop this from loading two times (first time had nil for movie title)
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("You tapped cell number \(indexPath.row).")

            //let selectedItem = movieArray8[indexPath.row]

            
    //        //.. to try to set an alert -- doesn't totally work with segue also
    //        var key = Array(self.movieDictionary8.keys)[indexPath.row]
    //        var value = Array(self.movieDictionary8.values)[indexPath.row]
    //
    //        print("*** key : \(key)")
    //        print("*** value: \(value)")
    //
    //        let selectedItem = key
    //
    //        let alert = UIAlertController(title: "Your Choice", message: "\(selectedItem)", preferredStyle: .alert)
    //
    //        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action -> Void in
    //            //Just dismiss the action sheet
    //            })
    //
    //        alert.addAction(okAction)
    //
    //        self.present(alert, animated: true) {
    //            print("alert done")
    //            return
    //        }
    //        //self.present(alert, animated: true , completion: nil )
    //
        
            self.performSegue(withIdentifier: "movieDetailSegue", sender: indexPath.row)
            
           
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            let selectedRow = sender as? Int
            print("selected row --->>>>> \(selectedRow)")
            
            var mRowSelected = movieArrayTupSorted2[selectedRow ?? 0]
            
//            var key2 = Array(self.movieDictionary8.keys)[selectedRow ?? 0]
//            var value2 = Array(self.movieDictionary8.values)[selectedRow ?? 0]
//
//            print("key2 --->>>>>>> \(key2)")
//            print("value2 --->>>>>>>> \(value2)")
            
            //.. if you used a func to pass data instead... but not necessary here
            //vc.setMovieDetail(fTitle: key2)
            var vc = segue.destination as! MovieDetailVC
            
            vc.movieTitle = mRowSelected.xName
            vc.movieYear = mRowSelected.xYear
            vc.movieType = mRowSelected.xType
            vc.movieIMDB = mRowSelected.xIMDB
            vc.moviePoster = mRowSelected.xPoster
            
//            vc.movieTitle = key2
//            vc.movieYear = value2.mYear
//            vc.movieType = value2.mType
//            vc.movieIMDB = value2.mIMDB
//            vc.moviePoster = value2.mPoster
            
        }

        func kamSetArray(movieArray: [String]) {

            //var movieArray8: [String] = ["movieArray8 test"]

            print("you are in setArray func....")
            print("movieArray coming in: \(movieArray)")
            print("movieArray8: \(movieArray8)")

            if !movieArray.isEmpty && movieArray.count >= 1 {
                //movieArray8 = movieArray
                movieArray8 = movieArray
                print(movieArray8)

            } else {
                print("movieArray has nothing in it...")
                movieArray8.append("BETTER LUCK NEXT TIME KAREN")
                print(movieArray8)

            }
            
            //self.tableView.reloadData()
            //print("you are in setArray func....")

        }
        
        func kamSetDictionary(movieDictionary: [String : (mYear: String, mType: String, mIMDB: String, mPoster: String)]) {
           
            //var movieArray8: [String] = ["movieArray8 test"]
            
            print("\nyou are in setDictionary func....")
            print("movieDictionary coming in with count = \(movieDictionary.count):\n \(movieDictionary)")
            print("movieDictionary8 with count = \(movieDictionary8.count):\n \(movieDictionary8)")
            
            if !movieDictionary.isEmpty && movieDictionary.count >= 1 {
                //movieArray8 = movieArray
                movieDictionary8 = movieDictionary
                //print(movieDictionary8)
                
            } else {
                print("movieDictionary has nothing in it...")
                movieDictionary8["Error"] = (mYear: "2020", mType: "", mIMDB: "", mPoster: "")
                print(movieDictionary8)
                
            }
            
            //self.tableView.reloadData()
            //print("you are in setArray func....")
            
        }

    

}
