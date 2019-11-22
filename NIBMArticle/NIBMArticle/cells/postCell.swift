//
//  postCell.swift
//  NIBMArticle
//
//  Created by MacBook on 11/22/19.
//  Copyright © 2019 NIBM. All rights reserved.
//


import UIKit
import Nuke

class postCell: UITableViewCell {
   

    @IBOutlet weak var postName: UILabel!
    
    @IBOutlet weak var postTitle: UILabel!
    
   @IBOutlet weak var postimage: UIImageView!
    
    @IBOutlet weak var postDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
 
    func populateData(post: postModel)  {
        
        postTitle.text = post.title
        postDesc.text = post.description
        postName.text = post.user
        
        let imgUrl = URL(string: post.image_url)
        
        Nuke.loadImage(with: imgUrl!, into: postimage)
        
    }
    
}
