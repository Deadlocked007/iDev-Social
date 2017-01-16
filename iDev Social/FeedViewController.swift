//
//  FeedViewController.swift
//  iDev Social
//
//  Created by Siraj Zaneer on 12/31/16.
//  Copyright © 2016 Siraj Zaneer. All rights reserved.
//

import UIKit
import Firebase
import AFNetworking

class FeedViewController: UITableViewController {
    
    var ref = FIRDatabase.database().reference()
    var imageRef = FIRStorage.storage().reference()

    
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(FeedViewController.loadMessages), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl!)
        
        loadMessages()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadMessages() {
        self.ref.observe(.value, with: { (snapshot) in
            self.posts = []
            if snapshot.hasChild("posts") {
                if let snapshots = snapshot.childSnapshot(forPath: "posts").children.allObjects as? [FIRDataSnapshot] {
                    for snap in snapshots {
                        if let postDict = snap.value as? Dictionary<String, AnyObject> {
                            let key = snap.key
                            let post = Post(postKey: key, dictionary: postDict)
                            self.posts.insert(post, at: 0)
                        }
                      
                    }
                    
                    self.tableView.reloadData()
                }
            }
            
        })
        refreshControl?.endRefreshing()
        
        

    }

    @IBAction func onSignOut(_ sender: Any) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") 
            self.present(viewController, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        
        
        if let imageId = post.imageId {
            print("hi")
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostPCell", for: indexPath) as! PostPCell
            cell.postLabel.text = post.text
            let imageRef = self.imageRef.child("images").child(imageId)
            
            guard let image = post.image else {
                imageRef.downloadURL(completion: { (url, error) in
                    if let url = url {
                        cell.postView.setImageWith(url)
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                })
                return cell
            }
            
            cell.postView.image = image
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
            
            cell.postLabel.text = post.text
            return cell
        }

    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
