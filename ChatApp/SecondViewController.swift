//
//  SecondViewController.swift
//  ChatApp
//
//  Created by  Арманай  on 4/13/20.
//  Copyright © 2020  Арманай . All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class SecondViewController: UIViewController {

    
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
   
    
   
  
    
                 
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }
    func register(){
       
        let emailText: String = email.text!
        let passwordText: String = password.text!
        let usernameText: String = username.text!
        if (emailText.isEmpty || passwordText.isEmpty || usernameText.isEmpty){
            showToast(message: "Tupoi chtole?")
        }
        else{
            Auth.auth().createUser(withEmail: email.text!, password: password.text!){
            (result,error) in
            if let error = error {
            print(error.localizedDescription)
            return
            }
                self.saveUser(uid:(result?.user.uid)!, username: usernameText, email: emailText, password: passwordText)
            self.showToast(message: "molodec")
            self.dismiss(animated: false , completion : nil)
            print("User added")
                               }
                   
        }
                   
              }
    private func saveUser(uid:String , username: String , email: String , password: String){
    
        Firestore.firestore().collection("users").document(uid).setData(
        [
                             "uid" : uid,
                             "username" : username,
                             "email" : email,
                             "password" : password
                             ]
        )
       }

    @IBAction func signup(_ sender: UIButton) {
    register()
       
}
        // Do any additional setup after loading the view.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
extension UIViewController {
func showToast(message : String) {
    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }
