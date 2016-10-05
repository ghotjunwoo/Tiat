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
    @IBOutlet var happySlider: UISlider!
    @IBOutlet var sadSlider: UISlider!
    @IBOutlet var lonleySlider: UISlider!
    @IBOutlet var angerSlider: UISlider!
    @IBOutlet var loveSlider: UISlider!
    @IBOutlet var unrestSlider: UISlider!
    
    let user = FIRAuth.auth()?.currentUser
    let step: Float = 1
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let feelingRef = FIRDatabase.database().reference().child("users/\(user!.uid)/currentdata/feeling")
        feelingRef.child("happy").observe(.value) { (snap: FIRDataSnapshot) in
            if snap.value is NSNull {} else {
                self.happySlider.value = snap.value as! Float
                self.happyValueLabel.text = snap.value as? String
                feelingRef.child("sad").observe(.value, with: { (snap: FIRDataSnapshot) in
                    self.sadSlider.value = snap.value as! Float
                    self.sadValueLabel.text = (snap.value as? String)?.description
                })
                feelingRef.child("love").observe(.value, with: { (snap: FIRDataSnapshot) in
                    self.loveSlider.value = snap.value as! Float
                    self.loveValueLabel.text = (snap.value as? String)?.description
                })
                feelingRef.child("anger").observe(.value, with: { (snap: FIRDataSnapshot) in
                    self.angerSlider.value = snap.value as! Float
                    self.angerValueLabel.text = (snap.value as? String)?.description
                })
                feelingRef.child("lonley").observe(.value, with: { (snap: FIRDataSnapshot) in
                    self.lonleySlider.value = snap.value as! Float
                    self.lonleyValueLabel.text = (snap.value as? String)?.description
                })
                feelingRef.child("unrest").observe(.value, with: { (snap: FIRDataSnapshot) in
                    self.unrestSlider.value = snap.value as! Float
                    self.unrestValueLabel.text = (snap.value as? String)?.description
                })
            }
        }
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
