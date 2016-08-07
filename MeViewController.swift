//
//  FirstViewController.swift
//  Tiat
//
//  Created by JWPC1 on 2016. 8. 1..
//  Copyright © 2016년 JW. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseMessaging

class FirstViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var pointLabel: UILabel!
    @IBOutlet var birthDayLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = FIRAuth.auth()?.currentUser {
            let userRef = FIRDatabase.database().reference().child("users/\(user.uid)")
            let storageRef = FIRStorage.storage().reference().child("users/\(user.uid)/profileimage")
            let token = FIRInstanceID.instanceID().token()!
            
            print(userRef.child("name"))
            userRef.child("name").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                self.nameLabel.text = snap.value?.description
            }
            userRef.child("birthday").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                self.birthDayLabel.text = snap.value?.description
            }
            userRef.child("gender").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                self.genderLabel.text = snap.value?.description
            }
            userRef.child("point").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                self.pointLabel.text = snap.value?.description
            }
            storageRef.dataWithMaxSize(1 * 7168 * 7168) { (data, error) -> Void in
                if (error != nil) {
                } else {
                    self.profileImageView.image = UIImage(data: data!)
                }
            }
            print("Sucessfully Signed in")
            print(token)
            
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func logOutTriggerd(sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        performSegueWithIdentifier("logoutSegue", sender: self)
    }


}

