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

       

    @IBAction func searchMovieButtonPressed(_ sender:  UIButton) {
        
        print("hi kar. button pressed.")
        
    }
    

}
