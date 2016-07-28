//
//  PostCell.swift
//  myHood
//
//  Created by Neel Khattri on 7/26/16.
//  Copyright © 2016 SimpleStuff. All rights reserved.
//


// ANY MORE HELP NEEDED REVIEW MARK PRICE VIDEOS ON UDEMY IOS 9 VIDEOS: 78-81

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        //Always = 50% so that we can make a circle
        
        postImage.layer.cornerRadius = postImage.frame.width / 2.0
        
        postImage.clipsToBounds = true
    }
    
    // Creating the post and adding it to the cell - accesses the different properties of the post and puts it when the correct zones of the cell
    
    func configureCell (post: Post) {
        
        titleLabel.text = post.title
        
        descriptionLabel.text = post.postInfo
        
        //Takes our imagePath and converts the path back into a image to be later put look at the function imageForPath on the DataService file - the cycle restarts everytime the makeNewPost button is clicked
        
        postImage.image = DataService.instance.imageForPath(post.imagePath)
        
    }
}
