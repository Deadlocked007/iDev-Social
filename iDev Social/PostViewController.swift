//
//  PostViewController.swift
//  iDev Social
//
//  Created by Siraj Zaneer on 12/31/16.
//  Copyright © 2016 Siraj Zaneer. All rights reserved.
//

import UIKit
import Photos
import Firebase

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var postText: UITextView!
    
    var postRef = FIRDatabase.database().reference()
    var imageRef = FIRStorage.storage().reference()
    
    var postingImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPost(_ sender: Any) {
        addPost(imageId: nil)
    }

    @IBAction func test(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func addPost(imageId: String?) {
        let itemRef = self.postRef.child("posts").childByAutoId()
        
        if (postText.text != "") {
            var postItem = [
                "text": postText.text,
                ]
            if let imageId = imageId {
                postItem["image"] = imageId
            }
            
            itemRef.setValue(postItem)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            print(image)
            let data = UIImageJPEGRepresentation(image, 0.8)
            
            let photoRef = imageRef.child("images")
            
            let uuid = UUID().uuidString
            
            photoRef.child(uuid).put(data!, metadata: nil, completion: { (metadata, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print(metadata?.downloadURL() ?? "")
                    self.addPost(imageId: uuid)
                }
            })
        }
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
