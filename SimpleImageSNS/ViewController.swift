//
//  ViewController.swift
//  SimpleImageSNS
//
//  Created by 藤井陽介 on 2020/06/29.
//  Copyright © 2020 touyou. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Kingfisher

//
class ViewController: UIViewController, UITableViewDataSource {
    //
    @IBOutlet var tableView: UITableView!

    var posts: [Post] = []

    //
    override func viewDidLoad() {
        super.viewDidLoad()

        //
        tableView.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        //
        tableView.dataSource = self
        //
        tableView.allowsSelection = false
    }

    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //
        if Auth.auth().currentUser == nil {
            //
            performSegue(withIdentifier: "toLogin", sender: nil)
        } else {
            //
            Firestore.firestore().collection("posts").addSnapshotListener { snapshots, error in
                //
                if let error = error {
                    //
                    print(error)
                    return
                }

                //
                guard let documents = snapshots?.documents else {
                    return
                }

                //
                self.posts = []
                //
                for snapshot in documents {
                    //
                    let post = Post(data: snapshot.data())
                    //
                    self.posts.append(post)
                }
                //
                self.posts.sort(by: { a, b in a.date > b.date })
                //
                self.tableView.reloadData()
            }
        }
    }

    //
    @IBAction func tapAddButton() {
        //
        performSegue(withIdentifier: "toAdd", sender: nil)
    }

    //
    @IBAction func tapLogoutButton() {
        //
        try? Auth.auth().signOut()
        //
        if Auth.auth().currentUser == nil {
            performSegue(withIdentifier: "toLogin", sender: nil)
        }
    }

    //
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell: ContentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContentTableViewCell

        //
        let post = posts[indexPath.row]
        //
        cell.contentLabel.text = post.content
        //
        cell.contentImageView.kf.setImage(with: post.imageURL)
        //
        cell.dateLabel.text = post.getDateString()
        //
        cell.idLabel.text = post.userId
        return cell
    }
}

