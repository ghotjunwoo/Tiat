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
    
    let user = FIRAuth.auth()?.currentUser

    var currentProblemValue = false
    var problems = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TestButton.isMultipleSelectionEnabled = true;


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    @IBAction func markButtonSelected(_ radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {

            for button in radioButton.selectedButtons() {
                problems.removeAll()
                problems.append((button.titleLabel?.text)!)
                problems.append(" ")
        }

        }
    }
    
    @IBAction func nextButtonTapped(_ sender: AnyObject) {
        problems.append("에 고민이 있습니다")
        FIRDatabase.database().reference().child("users/\((FIRAuth.auth()?.currentUser)!.uid)/currentdata/problem").setValue(problems)
        performSegue(withIdentifier: "toInput_2", sender: self)
    }
    
}
