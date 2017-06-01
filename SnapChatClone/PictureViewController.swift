//
//  PictureViewController.swift
//  SnapChatClone
//
//  Created by admin on 01/06/2017.
//  Copyright © 2017 Alex Keaveney. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var descTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage]
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        imageView.image = image as! UIImage
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        
        nextButton.isEnabled = false
        
        //child to move in to deeper folders
        let imagesFolder = FIRStorage.storage().reference().child("images")
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)
        //puts file name
        
        imagesFolder.child("\(NSUUID().uuidString).png").put(imageData!, metadata: nil, completion: {(metadata, error) in
            
            print ("We tried to upload an image")
            if error != nil {
                print("We have an error: \(error)")
            }
            else {
                
                print("meta: \(metadata?.downloadURL())")
                
                self.performSegue(withIdentifier: "selectUserSegue", sender: nil)
            }
        })
        

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        
    }
    

}
