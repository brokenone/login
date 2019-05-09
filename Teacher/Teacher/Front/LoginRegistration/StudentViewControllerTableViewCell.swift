//
//  StudentViewControllerTableViewCell.swift
//  Teacher
//
//  Created by Mac-Gor on 5/6/19.
//  Copyright © 2019 Hrayr. All rights reserved.
//

import UIKit

class StudentViewControllerTableViewCell: UITableViewCell {
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var studentImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
