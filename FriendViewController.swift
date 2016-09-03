//
//  FriendViewController.swift
//  Tiat
//
//  Created by 이종승 on 2016. 9. 3..
//  Copyright © 2016년 JW. All rights reserved.
//

import UIKit

class FriendViewController: UIViewController {
    enum Friend {
        case profileImage
        case currentStatus
        case statusColor
        case name
    }
    var friends = [Friend]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func loadFriends () {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
