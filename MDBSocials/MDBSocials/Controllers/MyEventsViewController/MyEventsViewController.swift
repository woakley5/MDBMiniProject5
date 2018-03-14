//
//  MyEventsViewController.swift
//  MDBSocials
//
//  Created by Will Oakley on 3/3/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit

class MyEventsViewController: UIViewController {

    var eventsTableView: UITableView!
    var posts: [Post] = []
    var selectedPost: Post!
    var postsLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        eventsTableView.reloadData()
    }
    
    func setupNavigationBar(){
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
        self.tabBarController?.navigationItem.title = "My Events"
        self.tabBarController?.navigationController?.navigationBar.tintColor = .white
        self.tabBarController?.navigationController?.navigationBar.barTintColor = .MDBBlue
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        tabBarController?.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func setupTableView(){
        eventsTableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        eventsTableView.separatorColor = .clear
        view.addSubview(eventsTableView)
        eventsTableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "post")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailViewController {
            let dest = segue.destination as! DetailViewController
            dest.post = selectedPost
        }
    }
}

extension MyEventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventsTableView.dequeueReusableCell(withIdentifier: "post", for: indexPath) as! FeedTableViewCell
        let post = posts[indexPath.row]
        cell.awakeFromNib()
        cell.startLoadingView()
        if post.image == nil {
            post.getPicture().then { success -> Void in
                cell.mainImageView.image = post.image
                cell.stopLoadingView()
            }
        }
        else{
            cell.mainImageView.image = post.image
        }
        cell.titleLabel.text = post.eventName
        var u = ""
        if post.posterName == nil {
            AlamofireClient.getUserWithId(id: post.posterId!).then { user in
                u = user.username! }.then {
                    DispatchQueue.main.async {
                        cell.posterNameLabel.text = "Created by: " + u
                        post.posterName = u
                    }
            }
        }
        else{
            cell.posterNameLabel.text = "Created by: " + post.posterName!
        }
        
        FirebaseDatabaseHelper.getInterestedUsers(postId: post.id!).then { (users) -> Void in
            let count = users.count
            if count == 1{
                cell.interestedLabel.text = String(describing: count) + " person interested"
            }
            else{
                cell.interestedLabel.text = String(describing: count) + " people interested"
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPost = posts[indexPath.row]
        self.performSegue(withIdentifier: "showSocialDetailFromMyEvents", sender: self)
    }
}


