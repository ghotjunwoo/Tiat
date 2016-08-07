//
//  ProblemInputViewController.swift
//  Tiat
//
//  Created by 이종승 on 2016. 8. 3..
//  Copyright © 2016년 JW. All rights reserved.
//

import UIKit
import DLRadioButton

class ProblemInputViewController: UIViewController {

    @IBOutlet weak var DetailField: UITextField!
    @IBOutlet var TestButton: DLRadioButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TestButton.multipleSelectionEnabled = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func markButtonSelected(radioButton : DLRadioButton) {
        if (radioButton.multipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selectedButton()!.titleLabel!.text!));
        }
    }
    
    
}
