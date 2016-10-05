//
//  EntireChatViewController.swift
//  Tiat
//
//  Created by 이종승 on 2016. 10. 2..
//  Copyright © 2016년 JW. All rights reserved.
//

import UIKit
import Firebase

class EntireChatViewController: UIViewController {
    
    let userUid = FIRAuth.auth()?.currentUser!.uid
    @IBOutlet weak var TopBar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        let button =  UIButton(type: .custom)
        button.setTitle("Button", for: UIControlState.normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .selected)
        button.addTarget(self, action: #selector(EntireChatViewController.showChatViewController), for: UIControlEvents.touchUpInside)
        let userRef = FIRDatabase.database().reference().child("users/\(userUid!)")
        self.navigationItem.titleView = button
        userRef.child("name").observe(.value) { (snap: FIRDataSnapshot) in
            button.setTitle((snap.value as! String).description, for: .normal)
            button.setTitle((snap.value as! String).description, for: .selected)
        }
        print(userUid)
        
    }
    func showChatViewController() {
        performSegue(withIdentifier: "toChatLogController", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
