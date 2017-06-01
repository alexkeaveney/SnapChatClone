//
//  SnapsViewController.swift
//  SnapChatClone
//
//  Created by admin on 01/06/2017.
//  Copyright © 2017 Alex Keaveney. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var snaps : [Snap] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        //to pull information out of the firebase database
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childAdded, with: { (snapshot) in
            
            if let firebaseDict = snapshot.value as? [String: AnyObject] {
                    print(snapshot)
                let snap = Snap()
                snap.imageURL = firebaseDict["imageURL"] as! String
                snap.desc = firebaseDict["description"] as! String
                snap.from = firebaseDict["email"] as! String
                snap.key = snapshot.key
                self.snaps.append(snap)
            }
            })
            
            FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childRemoved, with: { (snapshot) in
                
                var index = 0
                
                for snap in snaps {
                    
                }
                
            })
            
            self.tableView.reloadData()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = snaps[indexPath.row].from
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "viewSnapSegue", sender: snap)
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "viewSnapSegue") {
            let nextVC = segue.destination as! ViewSnapViewController
            nextVC.snap = sender as! Snap
        }
    }
    

}
