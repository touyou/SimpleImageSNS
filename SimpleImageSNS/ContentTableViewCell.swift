//
//  ContentTableViewCell.swift
//  SimpleImageSNS
//
//  Created by 藤井陽介 on 2020/06/29.
//  Copyright © 2020 touyou. All rights reserved.
//

import UIKit

//
class ContentTableViewCell: UITableViewCell {
    //
    @IBOutlet var contentImageView: UIImageView!
    //
    @IBOutlet var idLabel: UILabel!
    //
    @IBOutlet var dateLabel: UILabel!
    // 
    @IBOutlet var contentLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
