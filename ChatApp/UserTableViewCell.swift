//
//  UserTableViewCell.swift
//  ChatApp
//
//  Created by  Арманай  on 4/16/20.
//  Copyright © 2020  Арманай . All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    
    func mainList(user: User){
        username.text = user.username
        email.text = user.email
        print(user.username)
    }
}
