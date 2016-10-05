//
//  addChatFriend.swift
//  Tiat
//
//  Created by 이종승 on 2016. 10. 2..
//  Copyright © 2016년 JW. All rights reserved.
//

import UIKit
import Firebase

class addChatFriend: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var users = [User]()
    var keys = [String]()
    var image = [UIImage]()
    let cellId = "friendsCell"
    var downloadURL: URL = NSURL(string: "") as! URL
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        keys.removeAll()
        fetchUser()
        
    }
    
    func fetchUser () {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: {snapshot in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User()
                
                user.name = dictionary["name"] as? String
                self.keys.append(snapshot.key)
                self.users.append(user)
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
            
        })
        for reference in keys {
            let user = User()
            let httpsReference = FIRStorage.storage().reference(forURL: "gs://tiat-ea6fd.appspot.com").child("users/\(reference)/profileimage") // your download URL
            httpsReference.data(withMaxSize: 1 * 7168 * 7168) { (data, error) -> Void in
                if (error != nil) {
                    // Uh-oh, an error occurred!
                    print(error?.localizedDescription)
                } else {
                    // Data for "images/stars.jpg" is returned
                    user.image = UIImage(data: data!)
                    self.users.append(user)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FriendTableViewCell
        let user = users[indexPath.row]
        cell.nameLabel.text = user.name
        cell.profileImage.image = user.image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newuser = users[indexPath.row]
        let usernname = newuser.name! as String
        print(usernname)
        print(keys[indexPath.row])
        let destinationViewController = ChatViewController()
        destinationViewController.toUid = keys[indexPath.row]
        destinationViewController.userName = usernname
        performSegue(withIdentifier: "toChatView", sender: self)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
