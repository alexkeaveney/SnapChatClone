//
//  SelectUserViewController.swift
//  SnapChatClone
//
//  Created by admin on 01/06/2017.
//  Copyright © 2017 Alex Keaveney. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SelectUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    var imageURL = ""
    var desc = ""
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        //to pull information out of the firebase database
        FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded, with: { (snapshot) in

            if let firebaseDict = snapshot.value as? [String: AnyObject] {
                
                let user = User()
                user.email = firebaseDict["email"] as! String
                user.UUID = snapshot.key
                self.users.append(user)
            }
            
            self.tableView.reloadData()
            
            self.navigationController?.popToRootViewController(animated: true)
            
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = users[indexPath.row].email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = users[indexPath.row]
        
        let snap = ["email": user.email, "description": desc, "imageURL": imageURL]
        FIRDatabase.database().reference().child("users").child(user.UUID).child("snaps").childByAutoId().setValue(snap)
        
    }



}
