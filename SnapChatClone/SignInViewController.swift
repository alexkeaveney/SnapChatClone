//
//  SignInViewController.swift
//  SnapChatClone
//
//  Created by admin on 01/06/2017.
//  Copyright © 2017 Alex Keaveney. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func turnUpTapped(_ sender: Any) {
        
        //first check if the user has an account
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("We tried to sign in")
            if error != nil {
                print("Hey we have a signin error \(error)")
                
                //If the user doesnt have an account sign them up
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to sign up")
                    if error != nil {
                        print("We had a signup error \(error)")
                    }
                    else {
                        print("Sign up succesful")
                        
                        //add the user into the database
                        
                        FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email!)
                        
                        
                         self.performSegue(withIdentifier: "signInSegue", sender: nil)
                    }
                })
            }
            else {
                print("Signed in successfully")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        })
        
        
        //if the user doesnt have an account sign them up
        
        
        
    }
    

}

