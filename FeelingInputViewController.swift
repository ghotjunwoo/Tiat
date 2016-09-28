//
//  FeelingInputViewController.swift
//  Tiat
//
//  Created by JWPC1 on 2016. 8. 6..
//  Copyright © 2016년 JW. All rights reserved.
//

import UIKit
import Firebase

class FeelingInputViewController: UIViewController {

    @IBOutlet var feelingDetailField: UITextField!
    @IBOutlet var happyValueLabel: UILabel!
    @IBOutlet var sadValueLabel: UILabel!
    @IBOutlet var lonleyValueLabel: UILabel!
    @IBOutlet var angerValueLabel: UILabel!
    @IBOutlet var loveValueLabel: UILabel!
    @IBOutlet var unrestValueLabel: UILabel!
    @IBOutlet var doNotDisturbSwitch: UISwitch!
    @IBOutlet var needsAttentionSwitch: UISwitch!
    
    let user = FIRAuth.auth()?.currentUser
    let step: Float = 1
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let feelingRef = FIRDatabase.database().reference().child("users/\(user!.uid)/currentdata/feeling")

        feelingRef.child("conditions/donotdisturb").setValue(false)
        feelingRef.child("conditions/needsattention").setValue(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    @IBAction func happyValueChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        happyValueLabel.text = "\(Int(roundedValue))"
    }
    @IBAction func sadValueChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        sadValueLabel.text = "\(Int(roundedValue))"
    }
    @IBAction func lonleyValueChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        lonleyValueLabel.text = "\(Int(roundedValue))"
    }
    @IBAction func angerValueChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        angerValueLabel.text = "\(Int(roundedValue))"
    }
    @IBAction func loveValueChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        loveValueLabel.text = "\(Int(roundedValue))"
    }
    @IBAction func unrestValueChange(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        unrestValueLabel.text = "\(Int(roundedValue))"
    }
    @IBAction func doNotDisturbSwitchValueChanged(_ sender: UISwitch) {
        let feelingRef = FIRDatabase.database().reference().child("users/\(user!.uid)/currentdata/feeling")

        if doNotDisturbSwitch.isOn {
            feelingRef.child("conditions/donotdisturb").setValue(true)
        } else {
            feelingRef.child("conditions/donotdisturb").setValue(false)
        }
    }
    @IBAction func needsAttentionSwitchValueChanged(_ sender: UISwitch) {
        let feelingRef = FIRDatabase.database().reference().child("users/\(user!.uid)/currentdata/feeling")

        if needsAttentionSwitch.isOn {
            feelingRef.child("conditions/needsattention").setValue(true)
        } else {
            feelingRef.child("conditions/needsattention").setValue(false)
        }
    }
    
    
    @IBAction func nextButtonTapped(_ sender: AnyObject) {
        let feelingRef = FIRDatabase.database().reference().child("users/\(user!.uid)/currentdata/feeling")
        feelingRef.child("happy").setValue(Int(happyValueLabel.text!))
        feelingRef.child("sad").setValue(Int(sadValueLabel.text!))
        feelingRef.child("lonley").setValue(Int(lonleyValueLabel.text!))
        feelingRef.child("anger").setValue(Int(angerValueLabel.text!))
        feelingRef.child("love").setValue(Int(loveValueLabel.text!))
        feelingRef.child("unrest").setValue(Int(unrestValueLabel.text!))

        feelingRef.child("detail").setValue(feelingDetailField.text!)
        performSegue(withIdentifier: "toMainScreen_3", sender: self)
    }
    
    
    
}
