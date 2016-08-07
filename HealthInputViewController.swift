//
//  HealthInputViewController.swift
//  Tiat
//
//  Created by JWPC1 on 2016. 8. 6..
//  Copyright © 2016년 JW. All rights reserved.
//

import UIKit
import Firebase

class HealthInputViewController: UIViewController {

    @IBOutlet var sleepLabel: UILabel!
    @IBOutlet var excerciseValueLabel: UILabel!
    @IBOutlet var diseaseValueLabel: UILabel!
    @IBOutlet var hurtValueLabel: UILabel!
    @IBOutlet var healthDetailField: UITextField!
    let step: Float = 1
    let healthRef = FIRDatabase.database().reference().child("user/\(FIRAuth.auth()?.currentUser!.uid)/currentdata/health)")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func sleepValueChanged(sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        sleepLabel.text = "\(Int(roundedValue))"
    }
    
    @IBAction func excerciseValueChanged(sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        excerciseValueLabel.text = "\(Int(roundedValue))"
    }

    @IBAction func diseaseValueChanged(sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        diseaseValueLabel.text = "\(Int(roundedValue))"
    }

    @IBAction func hurtValueChanged(sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        hurtValueLabel.text = "\(Int(roundedValue))"
    }
    @IBAction func okSelected(sender: AnyObject) {
        healthRef.child("sleep").setValue(Int(sleepLabel.text!))
        healthRef.child("excercise").setValue(Int(excerciseValueLabel.text!))
        healthRef.child("disease").setValue(Int(diseaseValueLabel.text!))
        healthRef.child("hurt").setValue(Int(hurtValueLabel.text!))
        healthRef.child("detail").setValue(healthDetailField.text!)
    }
}
