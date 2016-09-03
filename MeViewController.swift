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
    @IBOutlet var conditionLabel: UILabel!
    @IBOutlet var healthConditionLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var profileInformation: UIView!
    @IBOutlet var feelingHealthInformation: UIView!
    @IBOutlet var healthStatus: UILabel!
    @IBOutlet var circleGraph: CircleGraphView!
    @IBOutlet var sadCircleGraph: CircleGraphView!
    @IBOutlet var lonleyCircleCraph: CircleGraphView!
    @IBOutlet var angryCircleGraph: CircleGraphView!
    @IBOutlet var loveCircleGraph: CircleGraphView!
    @IBOutlet var unrestCircleGraph: CircleGraphView!
    @IBOutlet var sleepCircleGraph: CircleGraphView!
    @IBOutlet var excerciseCircleGraphView: CircleGraphView!
    @IBOutlet var diseaseCircleGraph: CircleGraphView!
    @IBOutlet var hurtCircleGraph: CircleGraphView!
    @IBOutlet var circleGraphView1: UIView!
    @IBOutlet var circleGraphView2: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = FIRAuth.auth()?.currentUser {
            let userRef = FIRDatabase.database().reference().child("users/\(user.uid)")
            let dataRef = userRef.child("currentdata")
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
            dataRef.child("feeling/detail").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                self.statusLabel.text = snap.value?.description
            }
            dataRef.child("health/detail").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                self.healthStatus.text = snap.value?.description
                
            }
            
            storageRef.dataWithMaxSize(1 * 7168 * 7168) { (data, error) -> Void in
                if (error != nil) {
                } else {
                    self.profileImageView.image = UIImage(data: data!)
                }
            }
            print("Sucessfully Signed in")
            print(token)
            self.profileInformation.layer.borderWidth = 1
            self.profileInformation.layer.borderColor = UIColor.blackColor().CGColor
            self.profileInformation.layer.cornerRadius = CGRectGetWidth(self.profileInformation.frame)/12
            self.profileInformation.layer.masksToBounds = true
            self.feelingHealthInformation.layer.borderWidth = 1
            self.feelingHealthInformation.layer.borderColor = UIColor.blueColor().CGColor
            self.feelingHealthInformation.layer.cornerRadius = CGRectGetWidth(self.feelingHealthInformation.frame)/12
            self.feelingHealthInformation.layer.masksToBounds = true
            self.circleGraphView1.layer.borderWidth = 1
            self.circleGraphView1.layer.borderColor = UIColor.lightGrayColor().CGColor
            self.circleGraphView1.layer.cornerRadius = CGRectGetWidth(self.feelingHealthInformation.frame)/12
            self.circleGraphView2.layer.masksToBounds = true
            self.circleGraphView2.layer.borderWidth = 1
            self.circleGraphView2.layer.borderColor = UIColor.lightGrayColor().CGColor
            self.circleGraphView2.layer.cornerRadius = CGRectGetWidth(self.feelingHealthInformation.frame)/12
            self.circleGraphView2.layer.masksToBounds = true
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
            self.profileImageView.layer.masksToBounds = true


            sadCircleGraph.arcColor = UIColor.blueColor()
            lonleyCircleCraph.arcColor = UIColor.grayColor()
            angryCircleGraph.arcColor = UIColor.purpleColor()
            loveCircleGraph.arcColor = UIColor.magentaColor()
            unrestCircleGraph.arcColor = UIColor.greenColor()
            sleepCircleGraph.arcColor = UIColor.darkGrayColor()
            excerciseCircleGraphView.arcColor = UIColor(red:0.00, green:0.39, blue:0.00, alpha:1.0)
            diseaseCircleGraph.arcColor = UIColor.brownColor()
            hurtCircleGraph.arcColor = UIColor.purpleColor()
        }

        
    }
    override func viewDidAppear(animated: Bool) {
        if let user = FIRAuth.auth()?.currentUser {

            let feelingRef = FIRDatabase.database().reference().child("users/\(user.uid)/currentdata/feeling")
            let healthRef = FIRDatabase.database().reference().child("users/\(user.uid)/currentdata/health")
            feelingRef.child("conditions/donotdisturb").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                if snap.value?.description == "1" {
                 self.conditionLabel.text = "방해금지"
                }
            }
            feelingRef.child("conditions/needsattention").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                if (snap.value?.description)! == "1" {
                    self.conditionLabel.text = "관심필요"
                }
            }
            healthRef.child("conditions/verysick").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                if (snap.value?.description)! == "1" {
                    self.healthConditionLabel.text = "매우아픔"
                }
            }
            healthRef.child("conditions/veryhealthy").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                if (snap.value?.description)! == "1" {
                    self.healthConditionLabel.text = "매우 건강함"
                }
            }
            feelingRef.child("detail").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                self.statusLabel.text = snap.value as? String
            }
            
            feelingRef.child("happy").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                if snap.value! is NSNull {
                    
                } else {
                    let happyValue = snap.value as! Float / 5
                    self.circleGraph.endArc = CGFloat(happyValue)
                    feelingRef.child("sad").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                        let sadValue = snap.value as! Float / 5
                        self.sadCircleGraph.endArc = CGFloat(sadValue)
                        
                    }
                    feelingRef.child("lonley").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                        let lonleyValue = snap.value as! Float / 5
                        self.lonleyCircleCraph.endArc = CGFloat(lonleyValue)
                        
                    }
                    feelingRef.child("anger").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                        let angerValue = snap.value as! Float / 5
                        self.angryCircleGraph.endArc = CGFloat(angerValue)
                        
                    }
                    feelingRef.child("love").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                        let loveValue = snap.value as! Float / 5
                        self.loveCircleGraph.endArc = CGFloat(loveValue)
                        
                    }
                    feelingRef.child("unrest").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                        let unrestValue = snap.value as! Float / 5
                        self.unrestCircleGraph.endArc = CGFloat(unrestValue)
                        
                    }
                    
                }
                
            }
            healthRef.child("sleep").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                if snap.value! is NSNull {} else {
                    let sleepValue = snap.value as! Float / 5
                    self.sleepCircleGraph.endArc = CGFloat(sleepValue)
                    healthRef.child("excercise").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                        let Value = snap.value as! Float / 5
                        self.excerciseCircleGraphView.endArc = CGFloat(Value)
                        
                    }
                    healthRef.child("disease").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                        let Value = snap.value as! Float / 5
                        self.diseaseCircleGraph.endArc = CGFloat(Value)
                        
                    }
                    healthRef.child("hurt").observeEventType(.Value) { (snap: FIRDataSnapshot) in
                        let Value = snap.value as! Float / 5
                        self.hurtCircleGraph.endArc = CGFloat(Value)
                        
                    }

                }

                
            }
            
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

