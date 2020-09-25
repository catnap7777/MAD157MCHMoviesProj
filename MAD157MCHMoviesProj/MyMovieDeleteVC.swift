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

        
//        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//            //.. tags are used to distinguish between the two picker on the view controller
//            if pickerView.tag == 1 {
//                let pickerTypeIndex = pickCarTypeObj.selectedRow(inComponent: 0)
//                carTypeChosen = pickerTypeData[pickerTypeIndex]
//
//                carTypeDesc = priusModelDictionary[carTypeChosen]?.desc as! String
//                carTypePrice = priusModelDictionary[carTypeChosen]?.price as! Double
//                print("pickerView tag1 triggered")
//            }
//
//            if pickerView.tag == 2 {
//                let pickerColorIndex = pickColorObj.selectedRow(inComponent: 0)
//                carColorChosen = pickerColorData[pickerColorIndex]
//
//                switch pickerColorIndex {
//                case 0:
//                    priusColorPict.image = UIImage.init(named: "electricStormBlue.png")
//                    pictureNameString = "electricStormBlue.png"
//                    carColorEnumChosen = PriusStructures.CarColor.Blue
//                    //print("pictureNameString in first VC1111 = \(pictureNameString)")
//                case 1:
//                    priusColorPict.image = UIImage.init(named: "windChillPearl.png")
//                    pictureNameString = "windChillPearl.png"
//                    carColorEnumChosen = PriusStructures.CarColor.Pearl
//                    //print("pictureNameString in first VC2222 = \(pictureNameString)")
//                case 2:
//                    priusColorPict.image = UIImage.init(named: "classicSilverMetallic.png")
//                    pictureNameString = "classicSilverMetallic.png"
//                    carColorEnumChosen = PriusStructures.CarColor.Silver
//                case 3:
//                    priusColorPict.image = UIImage.init(named: "magneticGrayMetallic.png")
//                    pictureNameString = "magneticGrayMetallic.png"
//                    carColorEnumChosen = PriusStructures.CarColor.Gray
//                case 4:
//                    priusColorPict.image = UIImage.init(named: "midnightBlackMetallic.png")
//                    pictureNameString = "midnightBlackMetallic.png"
//                    carColorEnumChosen = PriusStructures.CarColor.Black
//                case 5:
//                    priusColorPict.image = UIImage.init(named: "supersonicRed.png")
//                    pictureNameString = "supersonicRed.png"
//                    carColorEnumChosen = PriusStructures.CarColor.Red
//                case 6:
//                    priusColorPict.image = UIImage.init(named: "seaGlassPearl.png")
//                    pictureNameString = "seaGlassPearl.png"
//                    carColorEnumChosen = PriusStructures.CarColor.Pearl
//                default:
//                    priusColorPict.image = UIImage.init(named: "electricStormBlue.png")
//                    pictureNameString = "electricStormBlue.png"
//                    carColorEnumChosen = PriusStructures.CarColor.Blue
//                }
//            }
//
//        }

        
    
    @IBAction func deleteMyMoviePressed(_ sender: Any) {
        
    }
    

}
