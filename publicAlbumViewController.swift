//
//  publicAlbumViewController.swift
//  Tiat
//
//  Created by 이종승 on 2016. 8. 10..
//  Copyright © 2016년 JW. All rights reserved.
//

import UIKit
import Firebase
import MobileCoreServices

class publicAlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    let imagePicker = UIImagePickerController()
    let storageRef = FIRStorage.storage().referenceForURL("gs://tiat-ea6fd.appspot.com")

    var values = 1
    var imageArray:[UIImage] = [UIImage(named: "second")!]
    var metadata = FIRStorageMetadata()


    override func viewDidLoad() {
        super.viewDidLoad()
        let albumRef = FIRDatabase.database().reference().child("albumNum")
        albumRef.observeEventType(.Value) { (snap: FIRDataSnapshot) in
            print(snap.value as! Int)
            self.values = snap.value as! Int
        }
        print(values)
        let albumImageRef = FIRStorage.storage().referenceForURL("gs://tiat-ea6fd.appspot.com")
.child("albumNum")
        for num in 1...values {
            albumImageRef.child("\(num)").dataWithMaxSize(Int64.max, completion: {(data, error) in
                if error == nil {
                    self.imageArray.append(UIImage(data: data!)!)
                    self.collectionView.reloadData()
                } else {
                    print(error?.localizedDescription)
                }
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("publicAlbumCell", forIndexPath: indexPath) as! AlbumCollectionViewCell
        
        cell.imageView?.image = self.imageArray[indexPath.row]
        return cell
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let albumImageRef = FIRStorage.storage().referenceForURL("gs://tiat-ea6fd.appspot.com")
            .child("albumNum")
        self.dismissViewControllerAnimated(true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let newImage = UIImageJPEGRepresentation(image, 3.0)
        self.metadata.contentType = "image/jpeg"
        print("\(values + 1)")
        albumImageRef.child("\(values + 1)").putData(newImage!, metadata: self.metadata){metadata, error in
            if error == nil {self.collectionView.reloadData()}
            else {print(error?.localizedDescription)}
            
        }
        
    }
    
    @IBAction func plusButtonTapped(sender: AnyObject) {
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    

}
