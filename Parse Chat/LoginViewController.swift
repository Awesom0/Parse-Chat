//
//  LoginViewController.swift
//  Parse Chat
//
//  Created by Felipe De La Torre on 10/10/18.
//  Copyright © 2018 Felipe De La Torre. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    // allow users to sign up
    func signUp() {
        //initialize a user object
        var newUser = PFUser()
        
        // set the new users properties:
        newUser.username = userNameField.text
        //newUser.email = emailField.text
        newUser.password = passwordField.text
        
        //calls the sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                self.usernameAlreadyExists()
                
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    
    
    
    // allows users to login
    func loginUser() {
        
        let username = userNameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                self.loginFailed()
                
            } else {
                print("User logged in successfully")
                
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
            }
        }
    }
    
    func usernameAlreadyExists(){
        
        let alertController = UIAlertController(title: "Error", message: "Username already exists. Please try a different one.", preferredStyle: .alert)
    
        // add an ok button
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        // add the OK button to the alert controller
        alertController.addAction(OKAction)
        //displays the alert message
        self.present(alertController, animated: true) {
            //end of alert message.
        }
    }
    
    
    func missingField(){
        
        //beginning of alert message:
        //needed to create alert message
        let alertController = UIAlertController(title: "Error", message: "Missing username or password.", preferredStyle: .alert)
        
        /*create a cancel action if nothing is pressed on the displayed screen
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // handle cancel response here. Doing nothing will dismiss the view.
        }
        // add the cancel action to the alertController
        alertController.addAction(cancelAction)
        */
        
        
        // add an ok button
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        // add the OK button to the alert controller
        alertController.addAction(OKAction)
        //displays the alert message
        self.present(alertController, animated: true) {
            //end of alert message.
        }
        
    }
    
    func loginFailed(){
     
        let alertController = UIAlertController(title: "Error", message: "Incorrect username or password. Please try again.", preferredStyle: .alert)
        
        // add an ok button
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        // add the OK button to the alert controller
        alertController.addAction(OKAction)
        //displays the alert message
        self.present(alertController, animated: true) {
            //end of alert message.
        }
    }
    
    
    // sign up button action
    @IBAction func onSIgnUp(_ sender: Any) {
        let testPass = (passwordField.text?.isEmpty)!
        let testUser = (userNameField.text?.isEmpty)!
        if testPass || testUser == true {
            
            missingField()
        } else {
            
           signUp()
        }
    }
 
    // log in button action
    @IBAction func onLogIn(_ sender: Any) {
        let testPass = (passwordField.text?.isEmpty)!
        let testUser = (userNameField.text?.isEmpty)!
        if testPass || testUser == true {
            
           missingField()
        } else {
            
            loginUser()
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

