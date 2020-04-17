//
//  ChatViewController.swift
//  ChatApp
//
//  Created by  Арманай  on 4/16/20.
//  Copyright © 2020  Арманай . All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class ChatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var tableView: UITableView!
    
    
    private var chats = [Chat?]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
   
    @IBAction func sendMessage(_ sender: Any) {
        if (Auth.auth().currentUser != nil){
            print(Auth.auth().currentUser?.uid as Any)
            
        
        }
    
    }
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(true)
       
        self.loadUserChatData(id: Auth.auth().currentUser!.uid)
        }
 
    
    private func loadUserChatData(id: String){
        Firestore.firestore()
           .collection("chats")
        .whereField("participantIds", arrayContains: id)
           .addSnapshotListener { (snapshot, error) in
            
            if let error = error {
                print(error.localizedDescription)
                
            }
            var chatList = [Chat?]()
            for document in snapshot!.documents {
                chatList.append(Chat(data: document.data()))
            }
            for c in chatList{
                for i in c!.participantIds{
                    if i != id {
                        self.chats.append(c)
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
  
   
    func tableView (_ tableView: UITableView, numberOfRowsInSection : Int) -> Int{
        return chats.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatList", for: indexPath) as? ChatListTableViewCell

        cell?.setChat(c: chats[indexPath.row]!)
        print(chats[indexPath.row]!)
        return cell!
    }
    func tableView (_ tableView: UITableView, didSelectRowAt indexPath : IndexPath) {
        view.endEditing(true)
        
    }}
