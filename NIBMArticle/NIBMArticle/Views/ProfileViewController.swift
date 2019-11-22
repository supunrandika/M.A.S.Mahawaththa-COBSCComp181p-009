//
//  ProfileViewController.swift
//  NIBMArticle
//
//  Created by MacBook on 11/22/19.
//  Copyright © 2019 NIBM. All rights reserved.
//

import UIKit
import Firebase
import LocalAuthentication

class ProfileViewController: UIViewController {
 var window: UIWindow?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // Do any additional setup after loading the view.
    }
    
 
    
    @IBAction func logOut_btn(_ sender: Any) {
       print("Click log")
//        _ = Auth.auth()
//        do {
//
//            UserDefaults.standard.removeObject(forKey: "LoggedUser")
//            UserDefaults.standard.removeObject(forKey: "LoggedIn")
//            UserDefaults.standard.removeObject(forKey: "UserUID")
//            UserDefaults.standard.synchronize()
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginsb")
//            self.present(vc, animated: true, completion: nil)
//
//
//        } catch let signOutError as NSError {
//            print ("Error signing out: %@", signOutError)
//        }
    }
    
    @IBAction func GotoMyProfile(_ sender: Any) {
        
        let authContext = LAContext()
        let authReason = "Please use Touch ID to access Your Account"
        var authError : NSError?
        
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError){
            
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: authReason, reply: { (success,error) -> Void in
                
                if error != nil{
                    DispatchQueue.main.async {
                        self.alert(message: "Authentication Failed")
                    }
                    return
                }
                
                
                if success{
                    //Go to My Account Page
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "Home", bundle: nil)
                        
                        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MyProfileEdit")
                        
                        self.window?.rootViewController = initialViewController
                        self.window?.makeKeyAndVisible()
                    }
                }
                
                
            })
            
        }
        else{
            self.alert(message: "Authentication Failed")
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

