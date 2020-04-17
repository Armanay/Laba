//
//  UserTableViewController.swift
//  ChatApp
//
//  Created by  Арманай  on 4/16/20.
//  Copyright © 2020  Арманай . All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class UserTableViewController: UITableViewController {

    var users = [User?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? UserTableViewCell

        cell?.mainList(user: users[indexPath.row]!)
        return cell!
    }

     override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(true)
        loadUserData()       }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chat" {
            let chatViewController = segue.destination as! ChatViewController
            let user = users[tableView.indexPathForSelectedRow?.row ?? 0]!
            chatViewController.id = user.uid
        }
          }

    private func loadUserData(){
        Firestore.firestore().collection("users").addSnapshotListener{
            (snapshot , error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            for document in snapshot!.documents{
                self.users.append(User(data: document.data())!)
            }
            self.tableView.reloadData()
        }

    }
}
