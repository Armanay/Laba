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
class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageField: UITextField!
    
    private var messages = [Message?]()
    var users = [User?]()
    var id: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        if (Auth.auth().currentUser != nil){
            print(Auth.auth().currentUser?.uid as Any)
            self.createOrUpdateChat(senderId: Auth.auth().currentUser!.uid, friendId: id!, msg: messageField.text!)
            
        
        }
    else {
    print("house")
    }
    }
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(true)
        let chatId = Auth.auth().currentUser!.uid + id!
        self.loadMessageData(chatId: chatId)
        }
 
    
    @objc func loadMessageData(chatId: String){
        Firestore.firestore()
           .collection("messages")
        .whereField("chatId", isEqualTo: chatId)
           .addSnapshotListener { (snapshot, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            for document in snapshot!.documents {
                    self.messages.append(Message(data: document.data()))
            }
            self.tableView.reloadData()
        }
    }
    
    
    private func addMessage(chatId: String, msg: String, senderId:String){
        Firestore.firestore().collection("messages").addDocument(data:
            [
                "chatId": chatId,
                "senderId": senderId,
                "msg": msg,
                "creationTime": Timestamp.init()
            ]
        ).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                
                return
            }
             
            print("Success!")
        }
        
    }
    
    private func createOrUpdateChat(senderId: String, friendId: String, msg: String){
        let chatId1 = senderId + friendId
        let chatId2 = friendId + senderId
       // print("heyhey")
        //print(chatId2)
        //print(messages)
        Firestore.firestore().collection("chats")
            .whereField("id", arrayContainsAny: [chatId1, chatId2])
            .addSnapshotListener{ (snapshot, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            var chats = [Chat?]()
            for document in snapshot!.documents {
                chats.append(Chat(data: document.data()))
                }
                if(!chats.isEmpty){
                    self.isExistChat(chats: chats, senderId: senderId, friendId: friendId, msg: msg)
                }
                 else{
                 Firestore.firestore().collection("users")
                    .whereField("uid", arrayContainsAny: [senderId, friendId])
                 .addSnapshotListener{ (snapshot, error) in
                                       
                 if let error = error {
                  print(error.localizedDescription)
                                           
                 }
                 
                    var ids = [String]()
                    ids.append(senderId)
                    ids.append(friendId)
                    self.users.removeAll()
                    for document in snapshot!.documents {
                        self.users.append(User(data: document.data()))
                    }
                    self.updateChat(id: chatId1, participantIds: ids, participants: self.users, lastMessageTime: Timestamp.init(), lastMessage:  msg)
                                       
                               }
                           }        }
    }
    
    private func isExistChat(chats: [Chat?],senderId: String, friendId: String, msg: String){
        let chatId1 = senderId + friendId
        let chatId2 = friendId + senderId
        for c in chats{
            if(c?.id == chatId1 || c?.id == chatId2){
                self.updateChat(id: c!.id, participantIds: c!.participantIds, participants: c!.participants, lastMessageTime: Timestamp.init(), lastMessage: msg)
            }
            else{
                Firestore.firestore().collection("users")
                    .whereField("uid", arrayContainsAny: [senderId, friendId])
                    .addSnapshotListener{ (snapshot, error) in
                        
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                        var ids = [String?]()
                        ids.append(senderId)
                        ids.append(friendId)
                        self.users.removeAll()
                        for document in snapshot!.documents {
                            self.users.append(User(data: document.data()))
                        }
                        self.updateChat(id: chatId1, participantIds: ids as! [String], participants: self.users, lastMessageTime: Timestamp.init(), lastMessage:  msg)
                        
                }
            }
        }
       
    }
    
    private func updateChat(id: String, participantIds: [String], participants: [User?], lastMessageTime: Timestamp, lastMessage: String){
        Firestore.firestore().collection("chats").document(id).setData(
            [
                "id": id,
                "lastMessageTime": lastMessageTime,
                "lastMessage": lastMessage,
                "participantIds": participantIds,
                "participants": participants
            ]        )
        self.addMessage(chatId: id, msg: lastMessage, senderId: Auth.auth().currentUser!.uid)
        
    }
    func tableView (_ tableView: UITableView, numberOfRowsInSection : Int) -> Int{
        return messages.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "userChat", for: indexPath) as! MessageItem
        cell.setMessage(m: messages[indexPath.row]!)
        return cell
    }
    func tableView (_ tableView: UITableView, didSelectRowAt indexPath : IndexPath) {
        view.endEditing(true)
        
    }
    
    func tableView (_ tableView: UITableView, heightForRowAt indexPath : IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }}
