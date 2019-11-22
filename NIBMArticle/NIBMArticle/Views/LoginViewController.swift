//
//  LoginViewController.swift
//  NIBMArticle
//
//  Created by MacBook on 11/09/19.
//  Copyright © 2019 NIBM. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login_btn(_ sender: Any) {
        if userName.text?.isEmpty ?? true {
            self.alert(message: "Enter Email")
            return
        }
        
        if password.text?.isEmpty ?? true {
            self.alert(message: "Enter Password")
        }
        
        Auth.auth().signIn(withEmail: userName.text!, password: password.text!) { [weak self] user, error in
            guard let strongSelf = self else { return }
            
            if (error != nil){
                strongSelf.alert(message: error?.localizedDescription ?? "Error")
                return
            }else{
                strongSelf.performSegue(withIdentifier: "homeStoryboard", sender: self)
                
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
