//
//  AddPostViewController.swift
//  NIBMArticle
//
//  Created by MacBook on 11/22/19.
//  Copyright © 2019 NIBM. All rights reserved.
//

import UIKit
import Firebase

class AddPostViewController: UIViewController {

    @IBOutlet weak var title_txt: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var des_txt: UITextField!
    @IBOutlet weak var postImage: UIImageView!
    
    
    var imagePicker:UIImagePickerController!
    var ref = DatabaseReference.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        self.ref = Database.database().reference()
        
        postImage.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    @IBAction func upload_click(_ sender: Any) {
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func post_btn(_ sender: Any) {
        if (title_txt.text == "") {
            alert(message: "title is required")
            return
        }
        
        if (des_txt.text == ""){
            alert(message: "Description Is Required")
            return
        }
        if (postImage.image == nil){
            alert(message: "Image Is Required")
            return
        }
        self.saveData()
        navigationController?.popViewController(animated: true)
    }
    func saveData(){
        self.uploadMedia(image: postImage.image!){ url in
            self.saveImage(profileImageURL: url!){ success in
                if (success != nil){
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
    }
    
    func uploadMedia(image :UIImage, completion: @escaping ((_ url: URL?) -> ())) {
        let imageName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("posts").child(imageName)
        let imgData = self.postImage.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) { (metadata, error) in
            if error == nil{
                storageRef.downloadURL(completion: { (url, error) in
                    completion(url)
                })
            }else{
                print("error in save image")
                completion(nil)
            }
        }
    }
    func saveImage(profileImageURL: URL , completion: @escaping ((_ url: URL?) -> ())){
        let res = ["des": des_txt.text!,"image": profileImageURL.absoluteString,"title": title_txt.text!,"username": name.text!] as [String : Any]
        self.ref.child("post").childByAutoId().setValue(res)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.postImage.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
