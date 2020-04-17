//
//  ViewController.swift
//  ChatApp
//
//  Created by  Арманай  on 4/13/20.
//  Copyright © 2020  Арманай . All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func signIn(_ sender: UIButton) {
        signin()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func signin(){
        let emailText: String = self.email.text!
        let passwordText: String = self.password.text!
        if (emailText.isEmpty || passwordText.isEmpty ){
                   showToast(message: "Tupoi chtole?")
               }
               else{
        Auth.auth().signIn(withEmail: email.text!, password: password.text!){
            (result,error) in
            if let error = error {
                print( error.localizedDescription)
            return
            }

            self.performSegue(withIdentifier: "chats", sender: self)
            print(result?.user.email as Any)

            }
        }

       
        
    }
       }

    


