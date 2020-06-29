//
//  PostViewController.swift
//  SimpleImageSNS
//
//  Created by 藤井陽介 on 2020/06/29.
//  Copyright © 2020 touyou. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

//
class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    //
    @IBOutlet var contentTextField: UITextField!
    //
    @IBOutlet var contentImageView: UIImageView!

    //
    override func viewDidLoad() {
        super.viewDidLoad()

        //
        showImagePicker()
    }

    //
    func showImagePicker() {
        //
        let pickerController = UIImagePickerController()
        //
        pickerController.sourceType = .photoLibrary
        //
        pickerController.delegate = self
        //
        present(pickerController, animated: true, completion: nil)
    }

    //
    func showSimpleAlert(title: String, message: String) {
        //
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //
        present(alertController, animated: true, completion: nil)
    }

    //
    @IBAction func touchUpInsideChangeButton() {
        //
        showImagePicker()
    }

    //
    @IBAction func touchUpInsidePostButton() {
        //
        guard let content = contentTextField.text, !content.isEmpty else {
            showSimpleAlert(title: "投稿文が空欄です", message: "投稿文を入力してください。")
            return
        }
        //
        guard let image = contentImageView.image,
            let data = image.jpegData(compressionQuality: 0.2) else {
            showSimpleAlert(title: "画像が選択されていません", message: "画像を選択してください。")
            return
        }

        //
        let rootRef = Firestore.firestore().collection("posts")
        //
        let storageRef = Storage.storage().reference()

        //
        let postPlace = rootRef.document()
        //
        let imageName = postPlace.documentID + ".png"
        //
        storageRef.child("images/\(imageName)").putData(data, metadata: nil) { metadata, _ in

            //
            storageRef.child("images/\(imageName)").downloadURL { url, error in
                //
                postPlace.setData([
                    "content": content,
                    "created_at": Timestamp(),
                    "image_url": url?.absoluteString ?? "",
                    "user_id": Auth.auth().currentUser!.uid
                ]) { _ in
                    // 
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }

    //
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //
        dismiss(animated: true, completion: nil)
        //
        contentImageView.image = info[.originalImage] as? UIImage
    }
}
