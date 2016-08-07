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
    
    let feelingRef = FIRDatabase.database().reference().child("users/\(FIRAuth.auth()?.currentUser!.uid)/currentdata/feeling")
    let step: Float = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        feelingRef.child("conditions/donotdisturb").setValue(false)
        feelingRef.child("conditions/needsattention").setValue(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    @IBAction func happyValueChanged(sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        happyValueLabel.text = "\(Int(roundedValue))"
    }
    @IBAction func sadValueChanged(sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        sadValueLabel.text = "\(Int(roundedValue))"
    }
    @IBAction func lonleyValueChanged(sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        lonleyValueLabel.text = "\(Int(roundedValue))"
    }
    @IBAction func angerValueChanged(sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        angerValueLabel.text = "\(Int(roundedValue))"
    }
    @IBAction func loveValueChanged(sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        loveValueLabel.text = "\(Int(roundedValue))"
    }
    @IBAction func unrestValueChange(sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        unrestValueLabel.text = "\(Int(roundedValue))"
    }
    @IBAction func doNotDisturbSwitchValueChanged(sender: UISwitch) {
        if doNotDisturbSwitch.on {
            feelingRef.child("conditions/donotdisturb").setValue(true)
        } else {
            feelingRef.child("conditions/donotdisturb").setValue(false)
        }
    }
    @IBAction func needsAttentionSwitchValueChanged(sender: UISwitch) {
        if needsAttentionSwitch.on {
            feelingRef.child("conditions/needsattention").setValue(true)
        } else {
            feelingRef.child("conditions/needsattention").setValue(false)
        }
    }
    
    
    @IBAction func nextButtonTapped(sender: AnyObject) {
        let feelingRef = FIRDatabase.database().reference().child("users/\(FIRAuth.auth()?.currentUser!.uid)/currentdata/feeling")
        feelingRef.child("happy").setValue(Int(happyValueLabel.text!))
        feelingRef.child("sad").setValue(Int(sadValueLabel.text!))
        feelingRef.child("lonley").setValue(Int(lonleyValueLabel.text!))
        feelingRef.child("anger").setValue(Int(angerValueLabel.text!))
        feelingRef.child("love").setValue(Int(loveValueLabel.text!))
        feelingRef.child("unrest").setValue(Int(unrestValueLabel.text!))

        feelingRef.child("detail").setValue(feelingDetailField.text!)
        performSegueWithIdentifier("toMainScreen_3", sender: self)
    }
    
    
    
}
