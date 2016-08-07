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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = FIRAuth.auth()?.currentUser {
            let userRef = FIRDatabase.database().reference().child("\(user.uid)")
            userRef.child("name").observeEventType(.Value, withBlock: {
                snapshot in
                self.nameLabel.text = snapshot.value as? String
            })
            userRef.child("birthday").observeEventType(.Value, withBlock: {
                snapshot in
                self.birthDayLabel.text = snapshot.value as? String
            })
            userRef.child("point").observeEventType(.Value, withBlock: {
                snapshot in
                self.pointLabel.text = snapshot.value as? String
            })
            userRef.child("gender").observeEventType(.Value, withBlock: {
                snapshot in
                self.genderLabel.text = snapshot.value as? String
            })
            print("Sucessfully Signed in")
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

