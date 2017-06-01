//
//  ViewSnapViewController.swift
//  SnapChatClone
//
//  Created by admin on 01/06/2017.
//  Copyright © 2017 Alex Keaveney. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseDatabase
import Firebase
import FirebaseAuth

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var snapImageView: UIImageView!
    @IBOutlet weak var snapDesc: UILabel!
    
    var snap : Snap!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        snapDesc.text = snap.desc
        snapImageView.sd_setImage(with: URL(string: snap.imageURL))
        
    }

    //called when leaving view controller
    override func viewWillDisappear(_ animated: Bool) {
        
    FIRDatabase.database().reference().child("users").child((FIRAuth.auth()!.currentUser!.uid)).child("snaps") .child(snap.key).removeValue()
    }

}
