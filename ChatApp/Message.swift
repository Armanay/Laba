//
//  Message.swift
//  ChatApp
//
//  Created by  Арманай  on 4/16/20.
//  Copyright © 2020  Арманай . All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
struct Message{
    public var chatId: String
    public var creationTime: Timestamp
    public var msg: String
    public var senderId: String
    init?(data: [String: Any]) {
        
        guard let chatId = data["chatId"] as? String, let msg = data["msg"] as? String, let senderId = data["senderId"] as? String, let creationTime = data["creationTime"] as? Timestamp else {
            return nil
        }
    
        
        self.chatId = chatId
        self.msg = msg
        self.senderId = senderId
        self.creationTime = creationTime 
    }
    
}
