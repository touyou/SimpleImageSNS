//
//  LoginViewController.swift
//  SimpleImageSNS
//
//  Created by 藤井陽介 on 2020/06/29.
//  Copyright © 2020 touyou. All rights reserved.
//

import UIKit
import FirebaseAuth

//
class LoginViewController: UIViewController {

    //
    @IBOutlet var statusLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //
    @IBAction func touchUpInsideLoginButton() {
        //
        Auth.auth().signInAnonymously { result, error in
            //
            if error != nil {
                self.statusLabel.text = "ログイン中にエラーが発生しました。"
            } else {
                self.statusLabel.text = "ログイン成功。"
                //
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
