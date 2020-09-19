//
//  ListItem.swift
//  WallExample
//
//  Created by Mac on 12/09/2020.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class ListItem: UITableViewCell {

    @IBOutlet weak var postLabel : UILabel!
    @IBOutlet weak var postImage : UIImageView!
    var url : String?
    
    
    @IBAction func onAddToFavoritePress (sender : UIButton){
        print( ["url" : url])
        NotificationCenter.default.post(name: .onFavoriteAdded, object: nil , userInfo: ["url" : url])
    }
}
