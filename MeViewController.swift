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
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var conditionLabel: UILabel!
    @IBOutlet var healthConditionLabel: UILabel!
    @IBOutlet var problemLabel: UILabel!
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
    @IBOutlet weak var happyButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!
    @IBOutlet weak var lonleyButton: UIButton!
    @IBOutlet weak var angryButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = FIRAuth.auth()?.currentUser {
            let userRef = FIRDatabase.database().reference().child("users/\(user.uid)")
            let dataRef = userRef.child("currentdata")
            let storageRef = FIRStorage.storage().reference().child("users/\(user.uid)/profileimage")
            let token = FIRInstanceID.instanceID().token()!
            
            print(userRef.child("name"))
            userRef.child("name").observe(.value) { (snap: FIRDataSnapshot) in
                self.nameLabel.text = (snap.value as! String).description
            }
            userRef.child("point").observe(.value) { (snap: FIRDataSnapshot) in
                self.pointLabel.text = snap.value as? String
            }
            dataRef.child("feeling/detail").observe(.value) { (snap: FIRDataSnapshot) in
                if snap.value is NSNull {} else {
                    self.statusLabel.text = (snap.value as! String).description
                    dataRef.child("health/detail").observe(.value) { (snap: FIRDataSnapshot) in
                        if snap.value is NSNull {} else {
                        self.healthStatus.text
                            = (snap.value as! String).description
                        }
                    }
                }
            }

            
            storageRef.data(withMaxSize: 1 * 7168 * 7168) { (data, error) -> Void in
                if (error != nil) {
                } else {
                    self.profileImageView.image = UIImage(data: data!)
                }
            }
            print("Sucessfully Signed in")
            print(token)
            self.circleGraphView1.layer.borderWidth = 1
            self.circleGraphView1.layer.borderColor = UIColor.lightGray.cgColor
            self.circleGraphView1.layer.cornerRadius = self.feelingHealthInformation.frame.width/12
            self.circleGraphView2.layer.masksToBounds = true
            self.circleGraphView2.layer.borderWidth = 1
            self.circleGraphView2.layer.borderColor = UIColor.lightGray.cgColor
            self.circleGraphView2.layer.cornerRadius = self.feelingHealthInformation.frame.width/12
            self.circleGraphView2.layer.masksToBounds = true
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
            self.profileImageView.layer.masksToBounds = true


            sadCircleGraph.arcColor = UIColor.blue
            lonleyCircleCraph.arcColor = UIColor.gray
            angryCircleGraph.arcColor = UIColor.purple
            loveCircleGraph.arcColor = UIColor.magenta
            unrestCircleGraph.arcColor = UIColor.green
            sleepCircleGraph.arcColor = UIColor.darkGray
            excerciseCircleGraphView.arcColor = UIColor(red:0.00, green:0.39, blue:0.00, alpha:1.0)
            diseaseCircleGraph.arcColor = UIColor.brown
            hurtCircleGraph.arcColor = UIColor.purple
        }

        FIRMessaging.messaging().connect { (error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print("Sucess Messaging")
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        if let user = FIRAuth.auth()?.currentUser {

            let feelingRef = FIRDatabase.database().reference().child("users/\(user.uid)/currentdata/feeling")
            let healthRef = FIRDatabase.database().reference().child("users/\(user.uid)/currentdata/health")
            feelingRef.child("conditions/donotdisturb").observe(.value) { (snap: FIRDataSnapshot) in
                if snap.value is NSNull {} else {
                    if snap.value as! Bool == true {
                        self.conditionLabel.text = "방해금지"
                    } else {
                        
                    }
                    feelingRef.child("conditions/needsattention").observe(.value) { (snap: FIRDataSnapshot) in
                        if snap.value as! Bool == true {
                            self.conditionLabel.text = "관심필요"
                        }
                    }
                    
                    healthRef.child("conditions/verysick").observe(.value) { (snap: FIRDataSnapshot) in
                        if snap.value is NSNull {} else {

                        if snap.value as! Bool == true {
                            self.healthConditionLabel.text = "매우아픔"
                            healthRef.child("conditions/veryhealthy").observe(.value) { (snap: FIRDataSnapshot) in
                                if snap.value as! Bool == true {
                                    self.healthConditionLabel.text = "매우 건강함"
                                }                    }
                            }
                        }
                    }
                    
                }
                
            }
            
            feelingRef.child("detail").observe(.value) { (snap: FIRDataSnapshot) in
                self.statusLabel.text = snap.value as? String
            }
            
            feelingRef.child("happy").observe(.value) { (snap: FIRDataSnapshot) in
                if snap.value! is NSNull {
                    
                } else {
                    let happyValue = snap.value as! Float / 5
                    self.circleGraph.endArc = CGFloat(happyValue)
                    feelingRef.child("sad").observe(.value) { (snap: FIRDataSnapshot) in
                        let sadValue = snap.value as! Float / 5
                        self.sadCircleGraph.endArc = CGFloat(sadValue)
                        
                    }
                    feelingRef.child("lonley").observe(.value) { (snap: FIRDataSnapshot) in
                        let lonleyValue = snap.value as! Float / 5
                        self.lonleyCircleCraph.endArc = CGFloat(lonleyValue)
                        
                    }
                    feelingRef.child("anger").observe(.value) { (snap: FIRDataSnapshot) in
                        let angerValue = snap.value as! Float / 5
                        self.angryCircleGraph.endArc = CGFloat(angerValue)
                        
                    }
                    feelingRef.child("love").observe(.value) { (snap: FIRDataSnapshot) in
                        let loveValue = snap.value as! Float / 5
                        self.loveCircleGraph.endArc = CGFloat(loveValue)
                        
                    }
                    feelingRef.child("unrest").observe(.value) { (snap: FIRDataSnapshot) in
                        let unrestValue = snap.value as! Float / 5
                        self.unrestCircleGraph.endArc = CGFloat(unrestValue)
                        
                    }
                    feelingRef.child("detail").observe(.value, with: { (snap: FIRDataSnapshot) in
                        self.statusLabel.text = snap.value as? String
                    })
                    
                }
                
            }
            healthRef.child("sleep").observe(.value) { (snap: FIRDataSnapshot) in
                if snap.value! is NSNull {} else {
                    let sleepValue = snap.value as! Float / 5
                    self.sleepCircleGraph.endArc = CGFloat(sleepValue)
                    healthRef.child("excercise").observe(.value) { (snap: FIRDataSnapshot) in
                        let Value = snap.value as! Float / 5
                        self.excerciseCircleGraphView.endArc = CGFloat(Value)
                        
                    }
                    healthRef.child("disease").observe(.value) { (snap: FIRDataSnapshot) in
                        let Value = snap.value as! Float / 5
                        self.diseaseCircleGraph.endArc = CGFloat(Value)
                        
                    }
                    healthRef.child("hurt").observe(.value) { (snap: FIRDataSnapshot) in
                        let Value = snap.value as! Float / 5
                        self.hurtCircleGraph.endArc = CGFloat(Value)
                        
                    }
                    healthRef.child("detail").observe(.value, with: { (snap: FIRDataSnapshot) in
                        self.healthStatus.text = snap.value as? String
                    })

                }

                
            }
            FIRDatabase.database().reference().child("users/\(user.uid)/currentdata/problem").observe(.value, with: { (snap: FIRDataSnapshot) in
                self.problemLabel.text = snap.value as? String
            })
            
                    }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func logOutTriggerd(_ sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        performSegue(withIdentifier: "logoutSegue", sender: self)
    }


}

