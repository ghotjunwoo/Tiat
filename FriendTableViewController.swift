

//
//  FriendTableViewController.swift
//  Tiat
//
//  Created by 이종승 on 2016. 9. 23..
//  Copyright © 2016년 JW. All rights reserved.
//

import UIKit
import Firebase



class FriendTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var users = [User]()
    var keys = [String]()
    let cellId = "friendsCell"
    var downloadURL: URL = NSURL(string: "") as! URL
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        
    }
    
    func fetchUser () {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: {snapshot in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User()
                self.keys.append(snapshot.key)

                user.name = dictionary["name"] as? String
                
                
                self.users.append(user)
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
            
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(users.count)
        return users.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FriendTableViewCell
        let user = users[indexPath.row]
        cell.nameLabel.text = user.name
        for reference in keys {
            let httpsReference = FIRStorage.storage().reference(forURL: "gs://tiat-ea6fd.appspot.com").child("users/\(reference)/profileimage") // your download URL
            httpsReference.data(withMaxSize: 1 * 7168 * 7168) { (data, error) -> Void in
                if (error != nil) {
                    // Uh-oh, an error occurred!
                    print(error?.localizedDescription)
                } else {
                    print("Scdsf")
                    // Data for "images/stars.jpg" is returned
                    let starsImage: UIImage! = UIImage(data: data!)
                    DispatchQueue.main.async {
                        cell.profileImage.image = starsImage // by default, callbacks are raised on the main thread so this will work
                    }
                }}
        }
        
        
        return cell
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

