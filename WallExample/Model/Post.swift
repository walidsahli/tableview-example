//
//  Post.swift
//  WallExample
//
//  Created by Mac on 12/09/2020.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class Post {
    var label: String
    var image : UIImage
    var id : Int
    var url : String
    
    init(label : String , image : UIImage , id : Int, url : String) {
        self.image = image
        self.id = id
        self.label = label
        self.url = url
    }
}
