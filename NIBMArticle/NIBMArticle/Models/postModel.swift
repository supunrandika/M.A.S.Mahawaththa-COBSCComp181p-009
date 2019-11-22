//
//  postModel.swift
//  NIBMArticle
//
//  Created by MacBook on 11/22/19.
//  Copyright © 2019 NIBM. All rights reserved.
//

import Foundation


struct postModel: Codable {
 
    var title : String!
    var description : String!
    var user: String!
    var image_url: String!
    
    init(title: String, description: String,user: String,image_url:String) {
        self.title = title
        self.description = description
        self.user=user
        self.image_url=image_url
    }
    
    
    
    
}