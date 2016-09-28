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
    let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default){(ACTION) in
        print("B_T")}
    
    func login() {
        FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passwordField.text!, completion:{
            user, error in
            
            if error  != nil {
                let incorrectAlert = UIAlertController(title: "실패", message: "이메일 또는 비밀번호가 일치하지 않습니다", preferredStyle: UIAlertControllerStyle.alert);
                incorrectAlert.addAction(self.okAction);
                self.present(incorrectAlert, animated: true, completion: nil)
            } else {
                print("Sucess")
                self.performSegue(withIdentifier: "toMainScreen", sender: self)
                
            }
            
        })
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailField.endEditing(true)
        passwordField.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FIRAuth.auth()?.currentUser != nil {
            performSegue(withIdentifier: "toMainScreen", sender: self)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func createAccount(_ sender: AnyObject) {
        login()
    }

    @IBAction func NextField(_ sender: AnyObject) {
        passwordField.becomeFirstResponder()
    }
    
    @IBAction func GoPressed(_ sender: AnyObject) {
        login()
    }
    
        
}
