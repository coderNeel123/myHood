//
//  AddPostVC.swift
//  myHood
//
//  Created by Neel Khattri on 7/27/16.
//  Copyright © 2016 SimpleStuff. All rights reserved.
//


// ANY MORE HELP NEEDED REVIEW MARK PRICE VIDEOS ON UDEMY IOS 9 VIDEOS: 78-81

import UIKit

// UIImagePickerControllerDelegate, UINavigationControllerDelegate - need these two if ever want to have an image picker from Photos, and later have (variable name of the type: UIImagePickerController).delegate = self - look through code to see example, , the UITextFieldDelegate is for closing the text field when teh return key is hit



class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var titleField: UITextField!

    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var postImage: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    //Making the view look nicer
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        postImage.layer.cornerRadius = postImage.frame.width / 2.0
        
        postImage.clipsToBounds = true
        
        imagePicker = UIImagePickerController()
        
        //Needed because we access the delegate features
        
        imagePicker.delegate = self
        
        //These two lines that were called are part of closing the text field when the return key is hit
        
        self.titleField.delegate = self
        
        self.descriptionField.delegate = self
        
    }
    // Where the cycle begins
    
    @IBAction func makePostButtonPressed(sender: AnyObject) {
        
        if let title = titleField.text, let description = descriptionField.text, let img = postImage.image {
            
            //convert image into a path
            
            let imagePath = DataService.instance.saveImageAndCreatePath(img)
            
            //Passes the string values of the path for the image, the title, and the description
            
            let post = Post(imagePath: imagePath, title: title, description: description)
            
            //Calls the add post function where the image has already been created into a path, and overall all three values the imagePath, title, and description are strings which get encoded and decoded
            
            DataService.instance.addPost(post)
            
            dismissViewControllerAnimated(true, completion: nil)

        }
    }
    //Bye bye to new post screen
    
    @IBAction func cancelPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Creates a view controller for the image selection in photos
    
    @IBAction func addPictureButtonPressed(sender: UIButton) {
        
        //Just wanted to get rid of the text of the button so nothing is there later to interfere with how the user sees the image
        
        sender.setTitle("", forState: .Normal)
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
   //User selects photo which is then put into the photo parameter, and the postImage = that photo
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
        //User selects photo which is then put into the photo parameter, and the postImage = that photo

        postImage.image = image
    }
    
    //When the user hits return on the text field - we want to end/close the text field
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}
