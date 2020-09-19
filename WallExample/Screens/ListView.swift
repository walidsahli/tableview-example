//
//  ListView.swift
//  WallExample
//
//  Created by Mac on 12/09/2020.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class ListView: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    var posts : [Post] = [];
    var pagesNumber : Int = 5
    var favorites : [String] = []
    @IBOutlet weak var favoritesButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        favoritesButton.layer.cornerRadius = 20
        favoritesButton.imageView?.contentMode = .scaleAspectFit
        tableView.delegate = self
        tableView.dataSource = self
        getPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(_ : true)
        NotificationCenter.default.addObserver(self, selector: #selector(onFavoriteAdded(_:)), name: .onFavoriteAdded, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(_: true)
        NotificationCenter.default.removeObserver(self, name: .onFavoriteAdded,object: nil)
    }
    
    @objc func onFavoriteAdded (_ notification:Notification){
        if let data = notification.userInfo as? [String : String] {
            for (_ , value) in data {
                self.favorites.append(value)
                favoritesButton.titleLabel?.text = String(self.favorites.count)
            }
        }
    }
    
    func getPosts (nb : Int = 5){
        var request = URLRequest(url: URL(string: "https://shibe.online/api/shibes?count=" + String(nb))!)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode([String].self, from: data!)
                responseModel.forEach { (url) in
                    let imageUrl = URL(string: url)
                    let imageContent = try? Data(contentsOf: imageUrl! )
                    if let imageData = imageContent {
                        let image = UIImage(data: imageData)
                        let post = Post(label: "Image", image: image!, id: 1, url :url )
                        self.posts.append(post)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            } catch {
                print(error ,"JSON Serialization error")
            }
        }).resume()
    }
    
    @objc func onSeeFavoritesPress () {
        
    }
}


extension ListView : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listitem", for: indexPath) as! ListItem
        cell.url = self.posts[indexPath.row].url
        cell.postImage?.image = self.posts[indexPath.row].image
        cell.postImage.layer.cornerRadius = 10
        cell.postLabel?.text = self.posts[indexPath.row].label
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == self.posts.count{
            self.pagesNumber += 5
            getPosts(nb : self.pagesNumber)
        }
    }
}

extension Notification.Name {
    static let onFavoriteAdded = Notification.Name("onFavoriteAdded")
}
