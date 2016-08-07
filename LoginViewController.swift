//
//  LoginViewController.swift
//  Tiat
//
//  Created by 이종승 on 2016. 8. 2..
//  Copyright © 2016년 JW. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.Default){(ACTION) in
        print("B_T")}
    
    func login() {
        FIRAuth.auth()?.signInWithEmail(emailField.text!, password: passwordField.text!, completion:{
            user, error in
            
            if error  != nil {
                let incorrectAlert = UIAlertController(title: "실패", message: "이메일 또는 비밀번호가 일치하지 않습니다", preferredStyle: UIAlertControllerStyle.Alert);
                incorrectAlert.addAction(self.okAction);
                self.presentViewController(incorrectAlert, animated: true, completion: nil)
            } else {
                print("Sucess")
                self.performSegueWithIdentifier("toMainScreen", sender: self)
                
            }
            
        })
    }
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        emailField.endEditing(true)
        passwordField.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FIRAuth.auth()?.currentUser != nil {
            performSegueWithIdentifier("toMainScreen", sender: self)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func createAccount(sender: AnyObject) {
        login()
    }

    @IBAction func NextField(sender: AnyObject) {
        passwordField.becomeFirstResponder()
    }
    
    @IBAction func GoPressed(sender: AnyObject) {
        login()
    }
    
        
}
