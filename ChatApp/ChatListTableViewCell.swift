//
//  ChatListTableViewCell.swift
//  ChatApp
//
//  Created by  Арманай  on 4/17/20.
//  Copyright © 2020  Арманай . All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ChatListTableViewCell: UITableViewCell {

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   

    func setChat(c: Chat){
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        let formattedDate = formatter.string(from: c.lastMessageTime.dateValue())
        
        for user in c.participants{
            if user.uid != Auth.auth().currentUser?.uid{
                self.name.text = user.username
            }
        }
        
        self.message.text = c.lastMessage
        self.date.text = formattedDate
        
    }
}
