//
//  AddPostVC.swift
//  Movie Review
//
//  Created by C Sinclair on 12/16/15.
//  Copyright © 2015 femtobyte. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var linkField: UITextField!
    @IBOutlet weak var plotLinkField: UITextField!
    @IBOutlet weak var movieImage: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieImage.layer.cornerRadius = 15.0
        movieImage.clipsToBounds = true
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        titleField.delegate = self
        descriptionField.delegate = self
        linkField.delegate = self
        plotLinkField.delegate = self
    }
        
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }


    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveBtnPressed(sender: AnyObject) {
        if let title = titleField.text, let img = movieImage.image, let desc = descriptionField.text, let link = linkField.text, let plot = plotLinkField.text {
            let imgPath = DataService.instance.saveImgPath(img)
            let post = ReviewPost(imgPath: imgPath, postTitle: title, postDesc: desc, imdbLink: link, imdbPlot: plot)
            DataService.instance.addPost(post)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func addImage(sender: AnyObject) {
        sender.setTitle("", forState: .Normal)
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        movieImage.image = image
    }

    @IBAction func addIMDbLink(sender: AnyObject) {
        
    }
    
    @IBAction func addIMDbPost(sender: AnyObject) {
        
    }

}
