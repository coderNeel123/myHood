//
//  DataService.swift
//  myHood
//
//  Created by Neel Khattri on 7/27/16.
//  Copyright © 2016 SimpleStuff. All rights reserved.
//


// ANY MORE HELP NEEDED REVIEW MARK PRICE VIDEOS ON UDEMY IOS 9 VIDEOS: 78-81


import Foundation
import UIKit

class DataService {
    static let instance = DataService()
    
    let keyPost = "post"
    
    private var _loadedPosts = [Post]()
    
    var loadedPosts: [Post] {
        get {
            return _loadedPosts
        }
    }
    
    //Saves the data into bites - think of encrypting and decrypting example - this is the encrypting part of the example
    
    func savePosts () {
        
        let postsData = NSKeyedArchiver.archivedDataWithRootObject(_loadedPosts)
        
        NSUserDefaults.standardUserDefaults().setObject(postsData, forKey: keyPost)
        
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    //Reconverts the bites back into usuable string data, the decrypting part of the example - also a notification ahs been posted out for the VC to see later
    
    func loadPosts () {
        
        if let postsData = NSUserDefaults.standardUserDefaults().objectForKey(keyPost) as? NSData {
            
            if let postsArray = NSKeyedUnarchiver.unarchiveObjectWithData(postsData) {
                
                _loadedPosts = postsArray as! [Post]
            }
        }
        
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "postsLoaded", object: nil))
    }
    
    // Creates path for image
    
    func saveImageAndCreatePath(image: UIImage) -> String {
        
        let imageData = UIImagePNGRepresentation(image)
        
        let imagePath = "image\(NSDate.timeIntervalSinceReferenceDate()).png"
        
        let fullPath = documentsPathForFileName(imagePath)
        
        imageData?.writeToFile(fullPath, atomically: true)
        
        return imagePath
        
    }
    
    //Changes path back into image so PostCell function can get the image
    
    func imageForPath(path:String) -> UIImage? {
        
        let fullPath = documentsPathForFileName(path)
        
        let image = UIImage(named: fullPath)
        
        return image
    }
    
    //Takes the array and appends the newest post
    
    func addPost(post:Post) {
        
        _loadedPosts.append(post)
        
        savePosts()
        
        loadPosts()
    }
    
    // Converter for path to image and bunch of hard stuff to explain
    
    func documentsPathForFileName (name: String) -> String  {
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        let fullPath = path[0] as NSString
        
        return fullPath.stringByAppendingPathComponent(name)
    }
}