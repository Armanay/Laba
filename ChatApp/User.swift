//
//  User.swift
//  ChatApp
//
//  Created by  Арманай  on 4/16/20.
//  Copyright © 2020  Арманай . All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
struct User{
    var email: String
    var username: String
    var uid:String
    
    
    init?(data: [String: Any]) {
        
        guard let uid = data["uid"] as? String, let username = data["username"] as? String, let email = data["email"] as? String else {
            return nil
        }
    
        
        self.uid = uid
        self.username = username
        self.email = email
        
    }
}
