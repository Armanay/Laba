//
//  MessageItem.swift
//  ChatApp
//
//  Created by  Арманай  on 4/16/20.
//  Copyright © 2020  Арманай . All rights reserved.
//

import Foundation
import UIKit
class MessageItem :UITableViewCell{
   
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
     func setMessage(m: Message){
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        let formattedDate = formatter.string(from: m.creationTime.dateValue())
        
        self.nameLabel.text = m.msg
        self.dateLabel.text = formattedDate
        
    }
}

