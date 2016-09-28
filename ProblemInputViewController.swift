//
//  ProblemInputViewController.swift
//  Tiat
//
//  Created by 이종승 on 2016. 8. 3..
//  Copyright © 2016년 JW. All rights reserved.
//

import UIKit
import Firebase
import DLRadioButton

class ProblemInputViewController: UIViewController {

    @IBOutlet var TestButton: DLRadioButton!
    @IBOutlet var loveButton: DLRadioButton!
    @IBOutlet var healthButton: DLRadioButton!
    @IBOutlet var appearanceButton: DLRadioButton!
    @IBOutlet var dreamButton: DLRadioButton!
    @IBOutlet var weightButton: DLRadioButton!
    @IBOutlet var friendButton: DLRadioButton!
    @IBOutlet var exc: DLRadioButton!
    @IBOutlet var detail: UITextField!
    
    let user = FIRAuth.auth()?.currentUser

    var currentProblemValue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TestButton.isMultipleSelectionEnabled = true;


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        detail.endEditing(true)
    }
    
    @IBAction func markButtonSelected(_ radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            let userRef = FIRDatabase.database().reference().child("users/\(user!.uid)")

            let testRef = userRef.child("currentdata/problem/test")
            let loveRef = userRef.child("currentdata/problem/love")
            let healthRef = userRef.child("currentdata/problem/health")
            let appearanceRef = userRef.child("currentdata/problem/appearance")
            let dreamRef = userRef.child("currentdata/problem/dream")
            let weightRef = userRef.child("currentdata/problem/weight")
            let friendRef = userRef.child("currentdata/problem/friend")
            
            testRef.setValue(false)
            loveRef.setValue(false)
            healthRef.setValue(false)
            appearanceRef.setValue(false)
            dreamRef.setValue(false)
            weightRef.setValue(false)
            friendRef.setValue(false)


            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!))
                switch button.titleLabel!.text! {
                case "시험":
                    testRef.setValue(true)
                case "건강":
                    healthRef.setValue(true)
                case "외모":
                    appearanceRef.setValue(true)
                case "장래":
                    dreamRef.setValue(true)
                case "몸무게":
                    weightRef.setValue(true)
                case "친구":
                    friendRef.setValue(true)
                case "이성":
                    loveRef.setValue(true)
                default:
                    break
                }
            }
        } else {
            
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: AnyObject) {
        print(detail.text!)
        let userRef = FIRDatabase.database().reference().child("users/\(user!.uid)")
        userRef.child("currentdata/problem/detail").setValue(detail.text!)
        performSegue(withIdentifier: "toInput_2", sender: self)
    }
    
}
