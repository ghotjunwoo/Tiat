//
//  FullImageViewController.swift
//  Tiat
//
//  Created by 이종승 on 2016. 8. 10..
//  Copyright © 2016년 JW. All rights reserved.
//

import UIKit

class FullImageViewController: UIViewController {

    var image = UIImage()
    
    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = self.image

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    @IBAction func exportButtonClicked(sender: AnyObject) {
    }
    @IBAction func trashButtonClicked(sender: AnyObject) {
    }
    @IBAction func commentButtonClicked(sender: AnyObject) {
    }
}
