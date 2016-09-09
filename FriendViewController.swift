//
//  FriendViewController.swift
//  Tiat
//
//  Created by 이종승 on 2016. 9. 3..
//  Copyright © 2016년 JW. All rights reserved.
//

import UIKit
import Firebase

class FriendViewController: UIViewController {
    
    let user = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUser()
        
    }
    func fetchUser () {
        FIRDatabase.database().reference().child("users").observeEventType(.ChildAdded, withBlock: {snapshot in
        
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User()
                user.setValuesForKeysWithDictionary(dictionary)
                print(user.name)
                
            }
            print(snapshot)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
