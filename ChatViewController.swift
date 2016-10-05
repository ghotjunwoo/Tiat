//
//  ChatViewController.swift
//  Tiat
//
//  Created by Ghotjunwoo on 2016. 10. 2..
//  Copyright © 2016년 JW. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    let userUid = FIRAuth.auth()?.currentUser?.uid
    var toUid = ""
    let childChatRef = FIRDatabase.database().reference().child("chat").childByAutoId()
    var userName = ""
    @IBOutlet weak var topBar: UINavigationItem!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var inputTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        topBar.title = "Hello"
        
    }

    
    @IBAction func handleSend(_ sender: AnyObject) {
        handle()
    }
    
    @IBAction func handleSendByEnter(_ sender: AnyObject) {
        handle()
    }
    
    func handle() {
        print(toUid)
        let message = inputTextField.text!
        let timestamp: NSNumber = NSDate().timeIntervalSince1970 as NSNumber
        let organizedTimeStamp = timestamp as Int
        let fromId = userUid!
        let toId = toUid
        childChatRef.child("text").setValue(message)
        childChatRef.child("timestamp").setValue(organizedTimeStamp)
        childChatRef.child("fromId").setValue(fromId)
        childChatRef.child("toId").setValue(toId)
    }

}
