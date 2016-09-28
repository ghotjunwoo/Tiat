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
    let storageRef = FIRStorage.storage().reference(forURL: "gs://tiat-ea6fd.appspot.com")

    var values = 1
    var imageArray:[UIImage] = [UIImage(named: "second")!]
    var metadata = FIRStorageMetadata()


    override func viewDidLoad() {
        super.viewDidLoad()
        let albumRef = FIRDatabase.database().reference().child("albumnum")
        albumRef.observe(.value) { (snap: FIRDataSnapshot) in
            print(snap.value)
            
            self.values = snap.value as! Int
        }
        print(values)
        let albumImageRef = FIRStorage.storage().reference(forURL: "gs://tiat-ea6fd.appspot.com")
.child("albumNum")
        for num in 1...values {
            albumImageRef.child("\(num)").data(withMaxSize: Int64.max, completion: {(data, error) in
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "publicAlbumCell", for: indexPath) as! AlbumCollectionViewCell
        
        cell.imageView?.image = self.imageArray[(indexPath as NSIndexPath).row]
        return cell
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let albumImageRef = FIRStorage.storage().reference(forURL: "gs://tiat-ea6fd.appspot.com")
            .child("albumNum")
        self.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let newImage = UIImageJPEGRepresentation(image, 3.0)
        self.metadata.contentType = "image/jpeg"
        print("\(values + 1)")
        albumImageRef.child("\(values + 1)").put(newImage!, metadata: self.metadata){metadata, error in
            if error == nil {self.collectionView.reloadData()}
            else {print(error?.localizedDescription)}
            
        }
        
    }
    
    @IBAction func plusButtonTapped(_ sender: AnyObject) {
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    

}
