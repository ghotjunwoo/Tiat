//
//  HealthInputViewController.swift
//  Tiat
//
//  Created by JWPC1 on 2016. 8. 6..
//  Copyright © 2016년 JW. All rights reserved.
//

import UIKit
import Firebase

class HealthInputViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var sleepLabel: UILabel!
    @IBOutlet var excerciseValueLabel: UILabel!
    @IBOutlet var diseaseValueLabel: UILabel!
    @IBOutlet var hurtValueLabel: UILabel!
    @IBOutlet var healthDetailField: UITextField!
    @IBOutlet var verySickSwitch: UISwitch!
    @IBOutlet var veryHealthySwitch: UISwitch!
    
    
    let step: Float = 1
    let user = FIRAuth.auth()?.currentUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let healthRef = FIRDatabase.database().reference().child("users/\(user!.uid)/currentdata/health")
        
        healthRef.child("conditions/verysick").setValue(false)
        healthRef.child("conditions/veryhealthy").setValue(false)


    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func sleepValueChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        sleepLabel.text = "\(Int(roundedValue))"
    }
    
    @IBAction func excerciseValueChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        excerciseValueLabel.text = "\(Int(roundedValue))"
    }

    @IBAction func diseaseValueChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        diseaseValueLabel.text = "\(Int(roundedValue))"
    }

    @IBAction func hurtValueChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        hurtValueLabel.text = "\(Int(roundedValue))"
    }
    @IBAction func okSelected(_ sender: AnyObject) {
        let healthRef = FIRDatabase.database().reference().child("users/\(user!.uid)/currentdata/health")

        healthRef.child("sleep").setValue(Int(sleepLabel.text!))
        healthRef.child("excercise").setValue(Int(excerciseValueLabel.text!))
        healthRef.child("disease").setValue(Int(diseaseValueLabel.text!))
        healthRef.child("hurt").setValue(Int(hurtValueLabel.text!))
        healthRef.child("detail").setValue(healthDetailField.text!)
        
        performSegue(withIdentifier: "toMeScreen", sender: self)
    }
    
    @IBAction func verySickValueChange(_ sender: UISwitch) {
        let healthRef = FIRDatabase.database().reference().child("users/\(user!.uid)/currentdata/health")
        if verySickSwitch.isOn {
            healthRef.child("conditions/verysick").setValue(true)
        } else {
            healthRef.child("conditions/verysick").setValue(false)
        }
    }
    @IBAction func veryHealthyValueChanged(_ sender: UISwitch) {
        let healthRef = FIRDatabase.database().reference().child("users/\(user!.uid)/currentdata/health")
        if verySickSwitch.isOn {
            healthRef.child("conditions/veryhealty").setValue(true)
        } else {
            healthRef.child("conditions/verysick").setValue(false)
        }
    }
}
