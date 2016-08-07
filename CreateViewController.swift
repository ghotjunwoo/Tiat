//
//  CreateViewController.swift
//  Tiat
//
//  Created by 이종승 on 2016. 8. 3..
//  Copyright © 2016년 JW. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import MobileCoreServices

class CreateViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var passwordCheckField: UITextField!
    @IBOutlet var birthDayField: UITextField!
    @IBOutlet var genderControl: UISegmentedControl!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var registerButton: UIButton!
    
    let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.Default){(ACTION) in
        print("B_T")}
    let userRef = FIRDatabase.database().reference().child("users")
    let user = FIRAuth.auth()?.currentUser
    let imagePicker = UIImagePickerController()
    let storageRef = FIRStorage.storage().referenceForURL("gs://tiat-ea6fd.appspot.com")
    

    var gender = "남"
    var image:UIImage = UIImage(named: "status_green")!
    var metadata = FIRStorageMetadata()
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == birthDayField {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = UIDatePickerMode.Date
            textField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(CreateViewController.datePickerChanged(_:)), forControlEvents: .ValueChanged)
        }
    }
    
    func login() {
        FIRAuth.auth()?.signInWithEmail(emailField.text!, password: passwordField.text!, completion:{
            user, error in
            
            if error  != nil {
                let incorrectAlert = UIAlertController(title: "실패", message: "이메일 또는 비밀번호가 일치하지 않습니다", preferredStyle: UIAlertControllerStyle.Alert);
                incorrectAlert.addAction(self.okAction);
                self.presentViewController(incorrectAlert, animated: true, completion: nil)
            } else {
                print("Sucess")
                self.performSegueWithIdentifier("toMainScreen_2", sender: self)
                
            }
            
        })
    }
    
    
    
    func create() {
        FIRAuth.auth()?.createUserWithEmail(emailField.text!, password: passwordField.text!, completion: {
            user, error in
            
            if error != nil {
                let duplAlert = UIAlertController(title: "실패", message: "오류가 발생했습니다", preferredStyle: UIAlertControllerStyle.Alert);
                print(error?.localizedDescription)
                duplAlert.addAction(self.okAction);
                self.presentViewController(duplAlert, animated: true, completion: nil)
            } else {
                
                let profileImageRef = self.storageRef.child("users/\(user!.uid)/profileimage")
                self.metadata.contentType = "image/jpeg"
                let newImage = UIImageJPEGRepresentation(self.profileImageView.image!, 3.0)
                profileImageRef.putData(newImage!, metadata: self.metadata) { metadata, error in
                    
                    if error != nil {
                        
                    } else {
                        self.userRef.child("\(user!.uid)/name").setValue(self.nameField.text!)
                        self.userRef.child("\(user!.uid)/birthday").setValue(self.birthDayField.text!)
                        self.userRef.child("\(user!.uid)/gender").setValue(self.gender)
                        self.userRef.child("\(user!.uid)/point").setValue(0)
                        self.login()
                    }
                }
                self.registerButton.enabled = false
                
                
                
                
                
            }})
    }
    
    func datePickerChanged(sender:UIDatePicker) {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .FullStyle
        birthDayField.text = formatter.stringFromDate(sender.date)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImageView.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        passwordCheckField.delegate = self
        birthDayField.delegate = self
        imagePicker.delegate = self

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func nextKeyPressed(sender: AnyObject) {
        emailField.becomeFirstResponder()
    }
    
    @IBAction func emailNextKeyPressed(sender: AnyObject) {
        passwordField.becomeFirstResponder()
    }

    @IBAction func passwordNextKeyPressed(sender: AnyObject) {
        passwordCheckField.becomeFirstResponder()
    }

    @IBAction func registerButtonTapped(sender: AnyObject) {
        if passwordField.text == passwordCheckField.text {
            create()
            performSegueWithIdentifier("toMainScreen_2", sender: self)
        } else {
            let diffrentAlert = UIAlertController(title: "오류", message: "비밀번호와 비밀번호 확인이 일치하지 않습니다", preferredStyle: UIAlertControllerStyle.Alert)
            diffrentAlert.addAction(okAction)
            presentViewController(diffrentAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func selectProfilePhoto(sender: AnyObject) {
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func selectedValueChanged(sender: AnyObject) {
        switch genderControl.selectedSegmentIndex {
        case 0:
            gender = "남"
        case 1:
            gender = "여"
        case 2:
            gender = "기타"
        default:
            break;
        }
    }
    
}
