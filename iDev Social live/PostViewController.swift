//
//  PostViewController.swift
//  iDev Social live
//
//  Created by Siraj Zaneer on 1/19/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit
import Firebase
import Photos

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var postField: UITextField!

    var dataRef = FIRDatabase.database().reference()
    
    var storageRef = FIRStorage.storage().reference()
    
    @IBOutlet weak var postView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        postField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onGallery(_ sender: Any) {
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.allowsEditing = true
        imageController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(imageController, animated: true, completion: nil)
    }
    
    @IBAction func onPost(_ sender: Any) {
        print("Posting")
        let usersRef = dataRef.child("posts").childByAutoId()
        
        var postInfo: [String: String] = [:]
        
        postInfo["text"] = postField.text
        
        postInfo["user"] = FIRAuth.auth()?.currentUser?.email!
        
        guard let image = postView.image else {
            usersRef.setValue(postInfo)
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        let data = UIImageJPEGRepresentation(image, 0.8)
        
        let photoRef = storageRef.child("images")
        
        let uuid = UUID().uuidString
        
        photoRef.child(uuid).put(data!, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                postInfo["image"] = uuid
                usersRef.setValue(postInfo)
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("oh oh")
            return
        }
        
        postView.image = image
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
