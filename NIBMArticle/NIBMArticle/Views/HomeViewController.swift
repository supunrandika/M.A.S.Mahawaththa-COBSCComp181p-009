//
//  HomeViewController.swift
//  NIBMArticle
//
//  Created by MacBook on 11/22/19.
//  Copyright © 2019 NIBM. All rights reserved.
//

import UIKit
import Firebase
import LocalAuthentication

class HomeViewController: UIViewController {var postsList : [postModel] = []
 
    var ref: DatabaseReference!
    var window: UIWindow?


    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        tableView.dataSource = self as UITableViewDataSource
        tableView.delegate = self as UITableViewDelegate
        
//        getStudentData()

        // Do any additional setup after loading the view.
    }
    
    func getStudentData(){
        
        let friendsRef = ref.child("post")
        
        
        friendsRef.observe(.value){ snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                let studentDic = child.value as! NSDictionary
                
                let title = studentDic["title"] as! String
                let description = studentDic["des"] as! String
                let user = studentDic["username"] as! String
                let image_url = studentDic["image"] as! String
                
                let post = postModel(
                    title: title,
                    description: description,
                    user: user ,
                    image_url: image_url
                )
                
                self.postsList.append(post)
                
                print(child)
            }
            
            self.tableView.reloadData()
            
            
        }
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return postsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! postCell
        
        cell.selectionStyle = .none
        
        cell.populateData(post: postsList[indexPath.row])
        
        return cell
}
    
}
