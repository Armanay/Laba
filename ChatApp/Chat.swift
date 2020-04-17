//
//  Chat.swift
//  ChatApp
//
//  Created by  Арманай  on 4/16/20.
//  Copyright © 2020  Арманай . All rights reserved.
//

import Foundation
import FirebaseFirestore
import UIKit
struct Chat{
public var id: String
public var lastMessageTime: Timestamp
public var lastMessage: String = ""
public var participantIds: [String]
public var participants: [User]
init?(data: [String: Any]) {
    
    guard let id = data["id"] as? String, let lastMessage = data["lastMessage"] as? String,  let lastMessageTime = data["lastMessageTime"] as? Timestamp , let participantIds = data["participantIds"] as? [String] , let participants = data["participants"] as? [User] else {
        return nil
    }

    
    self.id = id
    self.lastMessage = lastMessage
    self.lastMessageTime = lastMessageTime
    self.participantIds = participantIds
    self.participants = participants
    }
}
