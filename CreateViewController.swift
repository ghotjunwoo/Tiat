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
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var registerButton: UIButton!
    
    //MARK: Declaration
    
    let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default){(ACTION) in
        print("B_T")}
    let userRef = FIRDatabase.database().reference().child("users")
    let user = FIRAuth.auth()?.currentUser
    let imagePicker = UIImagePickerController()
    let storageRef = FIRStorage.storage().reference(forURL: "gs://tiat-ea6fd.appspot.com")
    var userNum = 0

    var gender = "남"
    var image:UIImage = UIImage(named: "status_green")!
    var metadata = FIRStorageMetadata()
    
    func create() {
        FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: {
            user, error in
            
            if error != nil {
                let duplAlert = UIAlertController(title: "실패", message: "오류가 발생했습니다", preferredStyle: UIAlertControllerStyle.alert);
                print(error?.localizedDescription)
                duplAlert.addAction(self.okAction);
                self.present(duplAlert, animated: true, completion: nil)
            } else {
                
                let profileImageRef = self.storageRef.child("users/\(user!.uid)/profileimage")
                self.metadata.contentType = "image/jpeg"
                let newImage = UIImageJPEGRepresentation(self.profileImageView.image!, 3.0)
                profileImageRef.put(newImage!, metadata: self.metadata) { metadata, error in
                    
                    if error != nil {
                        
                    }
                }
                self.userRef.child("\(user!.uid)/name").setValue(self.nameField.text! as String)
                self.userRef.child("\(user!.uid)/point").setValue(0)
                self.registerButton.isEnabled = false
                
            }})
    }
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImageView.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        imagePicker.delegate = self
        userRef.child("usernum").observe(.value) { (snap: FIRDataSnapshot) in
            self.userNum = snap.value as! Int
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func nextKeyPressed(_ sender: AnyObject) {
        emailField.becomeFirstResponder()
    }
    
    @IBAction func emailNextKeyPressed(_ sender: AnyObject) {
        passwordField.becomeFirstResponder()
    }

    @IBAction func passwordNextKeyPressed(_ sender: AnyObject) {
        create()
        performSegue(withIdentifier: "toMainScreen_2", sender: self)
    }

    @IBAction func registerButtonTapped(_ sender: AnyObject) {
            create()
            performSegue(withIdentifier: "toMainScreen_2", sender: self)
    }
    
    @IBAction func selectProfilePhoto(_ sender: AnyObject) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        self.present(imagePicker, animated: true, completion: nil)
    }
    

}
