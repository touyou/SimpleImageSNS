//
//  Post.swift
//  SimpleImageSNS
//
//  Created by 藤井陽介 on 2020/06/29.
//  Copyright © 2020 touyou. All rights reserved.
//

import Foundation
import Firebase

//
class Post {
    //
    var content: String
    //
    var date: Date
    //
    var imageURL: URL?
    //
    var userId: String

    //
    init(data: [String: Any]) {
        //
        self.content = data["content"] as! String
        //
        self.date = (data["created_at"] as! Timestamp).dateValue()
        //
        self.imageURL = URL(string: data["image_url"] as! String)
        //
        self.userId = data["user_id"] as! String
    }

    //
    func getDateString() -> String {
        //
        let dateFormatter = DateFormatter()
        //
        dateFormatter.dateFormat = "yyyy/MM/dd"
        // 
        return dateFormatter.string(from: date)
    }
}
