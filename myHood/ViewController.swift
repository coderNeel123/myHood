//
//  ViewController.swift
//  myHood
//
//  Created by Neel Khattri on 7/26/16.
//  Copyright © 2016 SimpleStuff. All rights reserved.
//



// ANY MORE HELP NEEDED REVIEW MARK PRICE VIDEOS ON UDEMY IOS 9 VIDEOS: 78-81

import UIKit

// Call the UITableViewDelegate, UITableViewDataSource feautures when using table views
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Need these two parts when using the UITableViewDelegate, UITableViewDataSource featurues
        
        tableView.delegate = self
        
        tableView.dataSource = self

        // Notification has been recieved and does the onPostsLoaded function which just reloads the data in the table
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.onPostsLoaded(_:)), name: "postsLoaded", object: nil)
        
        // Update all posts that were saved beforehand and a long time ago - make our table up to date
        
        DataService.instance.loadPosts()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //takes in the data from the array as the Post(...) part of the Post class
        
        let post = DataService.instance.loadedPosts[indexPath.row]
        
        //Looks for a unused cell so we can reuse it
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
            
            // Calls in the function in the PostCell class using the post which was initialized and later decoded and encoded in the Post Class - look there to see how a post is broken down
            
            cell.configureCell(post)
            
            return cell
        }
            
        else {
            //This is just incase something goes wrong and we can't access the cell so we just manually take our post and create a new cell to use for the configureCell function, rather than looking for a reusable cell that is not being currently user with the dequeueReusableCellWith... - that piece of code basically looks for a cell that is not currently being used and reuses it, so that we don't need to store a million cells in our code, rather we store 30 that we keep reusing
            
            let cell = PostCell()
            
            cell.configureCell(post)
            
            return cell
        }
    }
    
    //Height for each row
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 85.5
    }
    
    //Number of rows in our section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //The amount of posts in our loadedPosts array which stores all the posts
        
        return DataService.instance.loadedPosts.count
    }
    
    //Reloads teh data in the table
    
    func onPostsLoaded (notif: AnyObject) {
        
        tableView.reloadData()
    }
   }

