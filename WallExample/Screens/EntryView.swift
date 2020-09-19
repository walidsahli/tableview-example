//
//  ViewController.swift
//  WallExample
//
//  Created by Mac on 12/09/2020.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class EntryView: UIViewController {
    
    @IBOutlet weak var logo : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func onLogin (sender : UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "list") as! ListView
        navigationController?.show(screen, sender: self)
    }


}

