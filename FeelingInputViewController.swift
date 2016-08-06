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
    let user = FIRAuth.auth()?.currentUser
    let step: Float = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        

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
    
    @IBAction func nextButtonTapped(sender: AnyObject) {
        let feelingRef = FIRDatabase.database().reference().child("users/\(user!.uid)/currentdata/feeling")
        feelingRef.child("happy").setValue(happyValueLabel.text!)
        feelingRef.child("sad").setValue(sadValueLabel.text!)
        feelingRef.child("lonley").setValue(lonleyValueLabel.text!)
        feelingRef.child("anger").setValue(angerValueLabel.text!)
        feelingRef.child("love").setValue(loveValueLabel.text!)
        feelingRef.child("unrest").setValue(happyValueLabel.text!)

        
    }
    
    
    
}
