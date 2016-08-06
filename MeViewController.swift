//
//  FirstViewController.swift
//  Tiat
//
//  Created by JWPC1 on 2016. 8. 1..
//  Copyright © 2016년 JW. All rights reserved.
//

import UIKit
import Firebase

class FirstViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var pointLabel: UILabel!
    @IBOutlet var birthDayLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!

    override func viewWillAppear(animated: Bool) {
        if let user = FIRAuth.auth()?.currentUser {
            let userRef = FIRDatabase.database().reference().child("users/\(user.uid)")
            
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
            print("Sucessfully Signed in")
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

