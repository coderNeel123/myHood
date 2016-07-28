//
//  Post.swift
//  myHood
//
//  Created by Neel Khattri on 7/26/16.
//  Copyright © 2016 SimpleStuff. All rights reserved.
//


// ANY MORE HELP NEEDED REVIEW MARK PRICE VIDEOS ON UDEMY IOS 9 VIDEOS: 78-81

import Foundation

// Need to call  NSObject, NSCoding when using the encoding and decoding properties

class Post: NSObject, NSCoding {
    
    private var _imagePath: String!
    
    private var _title: String!
    
    private var _postInfo: String!
    
    var imagePath: String {
        
        get {
            
            return _imagePath
            
        }
    }
    
    var title: String {
        
        get {
            
            return _title

        }
    }
    
    var postInfo: String {
        
        get {
            
            return _postInfo
            
        }
    }
    
    init(imagePath: String, title: String, description:String) {
        
        self._imagePath = imagePath
        
        self._title = title
        
        self._postInfo = description
    }
    
    //These three function underneath are neath when using the encoding and decoding properties. Basically for every object you encode and decode you need to create a key for it and then using that key you need to decode it as below. This is not the actual saving points of the code it is just a needed feature when using the NSCoding and NSObject feautures which are mandatory when using the encoding and decoding features
    
    override init () {
        
    }
    
    //Needed when using the encoding and decoding properties so bascically all you do is create a key for each object you want to encode then call that same key again to decode it - this is the decoding part with the key names in ""
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        self.init()
        
        self._imagePath = aDecoder.decodeObjectForKey("imagePath") as? String
        
        self._title = aDecoder.decodeObjectForKey("title") as? String
        
        self._postInfo = aDecoder.decodeObjectForKey("description") as? String
        
    }
    
    // Need to also encode all the parts we use with the encoding and decoding properties - this is the encoding part - the key name created in the "" is the same for which you use in the decoding part above - only above -  so that everything can be encoded and decoded - see how the key anems are the same because they connect to each other when encoding and decoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(self._imagePath, forKey: "imagePath")
        
        aCoder.encodeObject(self._title, forKey: "title")
        
        aCoder.encodeObject(self._postInfo, forKey: "description")
    }
}