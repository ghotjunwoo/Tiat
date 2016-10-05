//
//  FriendDetailViewController.swift
//  Tiat
//
//  Created by 이종승 on 2016. 10. 1..
//  Copyright © 2016년 JW. All rights reserved.
//

import UIKit
import Firebase

class FriendDetailViewController: UIViewController {

    var friendUid = String()
    var friendName = String()
    @IBOutlet var informationView: UIView!
    @IBOutlet weak var circleGraphView1: UIView!
    @IBOutlet weak var happyCircleGraphView: CircleGraphView!
    @IBOutlet weak var sadCircleGraphView: CircleGraphView!
    @IBOutlet weak var lonleyCircleGraphView: CircleGraphView!
    @IBOutlet weak var angerCircleGraphView: CircleGraphView!
    @IBOutlet weak var loveCircleGraphView: CircleGraphView!
    @IBOutlet weak var unrestCircleGraphView: CircleGraphView!
    @IBOutlet weak var circleGraphView2: UIView!
    @IBOutlet weak var sleepCircleGraphVIew: CircleGraphView!
    @IBOutlet weak var excerciseCircleGraphView: CircleGraphView!
    @IBOutlet weak var diseaseCircleGraphView: CircleGraphView!
    @IBOutlet weak var hurtCIrcleGraphView: CircleGraphView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var healthConditonLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var healthStatusLabel: UILabel!
    @IBOutlet weak var problemLabel: UILabel!
    @IBOutlet var topBar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        sadCircleGraphView.arcColor = UIColor.blue
        lonleyCircleGraphView.arcColor = UIColor.gray
        angerCircleGraphView.arcColor = UIColor.purple
        loveCircleGraphView.arcColor = UIColor.magenta
        unrestCircleGraphView.arcColor = UIColor.green
        sleepCircleGraphVIew.arcColor = UIColor.darkGray
        excerciseCircleGraphView.arcColor = UIColor(red:0.00, green:0.39, blue:0.00, alpha:1.0)
        diseaseCircleGraphView.arcColor = UIColor.brown
        hurtCIrcleGraphView.arcColor = UIColor.purple
        self.circleGraphView1.layer.masksToBounds = true
        self.circleGraphView1.layer.borderWidth = 1
        self.circleGraphView1.layer.borderColor = UIColor.lightGray.cgColor
        self.circleGraphView1.layer.cornerRadius = self.informationView.frame.width/12
        self.circleGraphView1.layer.masksToBounds = true
        self.circleGraphView2.layer.masksToBounds = true
        self.circleGraphView2.layer.borderWidth = 1
        self.circleGraphView2.layer.borderColor = UIColor.lightGray.cgColor
        self.circleGraphView2.layer.cornerRadius = self.informationView.frame.width/12
        self.circleGraphView2.layer.masksToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let feelingRef = FIRDatabase.database().reference().child("users/\(friendUid)/currentdata/feeling")
        let healthRef = FIRDatabase.database().reference().child("users/\(friendUid)/currentdata/health")
        feelingRef.child("conditions/donotdisturb").observe(.value) { (snap: FIRDataSnapshot) in
            if snap.value is NSNull {} else {
                if snap.value as! Bool == true {
                    self.conditionLabel.text = "방해금지"
                    feelingRef.child("conditions/needsattention").observe(.value) { (snap: FIRDataSnapshot) in
                        if snap.value as! Bool == true {
                            self.conditionLabel.text = "관심필요"
                        }
                    }
                }
            }
            self.topBar.title = self.friendName
        }
        healthRef.child("conditions/verysick").observe(.value) { (snap: FIRDataSnapshot) in
            if snap.value is NSNull {} else {
                if snap.value as! Bool == true {
                    self.healthConditonLabel.text = "매우아픔"
                    healthRef.child("conditions/veryhealthy").observe(.value) { (snap: FIRDataSnapshot) in
                        if snap.value as! Bool == true {
                            self.healthConditonLabel.text = "매우건강함"
                        }
                    }
                }
            }
        }

        feelingRef.child("detail").observe(.value) { (snap: FIRDataSnapshot) in
            if snap.value is NSNull {} else {
                self.statusLabel.text = snap.value as? String
                healthRef.child("detail").observe(.value) { (snap: FIRDataSnapshot) in
                    self.healthStatusLabel.text = snap.value as? String
                }
            }
        }
        FIRDatabase.database().reference().child("users/\(friendUid)/currentdata/problem").observe(.value) { (snap: FIRDataSnapshot) in
            if snap.value is NSNull {} else {
                self.problemLabel.text = snap.value as? String
            }
        }
        
        feelingRef.child("happy").observe(.value) { (snap: FIRDataSnapshot) in
            if snap.value! is NSNull {
                
            } else {
                let happyValue = snap.value as! Float / 5
                self.happyCircleGraphView
                    
                    
                    .endArc = CGFloat(happyValue)
                feelingRef.child("sad").observe(.value) { (snap: FIRDataSnapshot) in
                    let sadValue = snap.value as! Float / 5
                    self.sadCircleGraphView.endArc = CGFloat(sadValue)
                    
                }
                feelingRef.child("lonley").observe(.value) { (snap: FIRDataSnapshot) in
                    let lonleyValue = snap.value as! Float / 5
                    self.lonleyCircleGraphView.endArc = CGFloat(lonleyValue)
                    
                }
                feelingRef.child("anger").observe(.value) { (snap: FIRDataSnapshot) in
                    let angerValue = snap.value as! Float / 5
                    self.angerCircleGraphView.endArc = CGFloat(angerValue)
                    
                }
                feelingRef.child("love").observe(.value) { (snap: FIRDataSnapshot) in
                    let loveValue = snap.value as! Float / 5
                    self.loveCircleGraphView.endArc = CGFloat(loveValue)
                    
                }
                feelingRef.child("unrest").observe(.value) { (snap: FIRDataSnapshot) in
                    let unrestValue = snap.value as! Float / 5
                    self.unrestCircleGraphView.endArc = CGFloat(unrestValue)
                    
                }
                
            }
            
        }
        healthRef.child("sleep").observe(.value) { (snap: FIRDataSnapshot) in
            if snap.value! is NSNull {} else {
                let sleepValue = snap.value as! Float / 5
                self.sleepCircleGraphVIew.endArc = CGFloat(sleepValue)
                healthRef.child("excercise").observe(.value) { (snap: FIRDataSnapshot) in
                    let Value = snap.value as! Float / 5
                    self.excerciseCircleGraphView.endArc = CGFloat(Value)
                    
                }
                healthRef.child("disease").observe(.value) { (snap: FIRDataSnapshot) in
                    let Value = snap.value as! Float / 5
                    self.diseaseCircleGraphView.endArc = CGFloat(Value)
                    
                }
                healthRef.child("hurt").observe(.value) { (snap: FIRDataSnapshot) in
                    let Value = snap.value as! Float / 5
                    self.hurtCIrcleGraphView.endArc = CGFloat(Value)
                    
                }
                
            }
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}
