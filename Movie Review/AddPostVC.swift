//
//  AddPostVC.swift
//  Movie Review
//
//  Created by C Sinclair on 12/16/15.
//  Copyright © 2015 femtobyte. All rights reserved.
//

import UIKit
import WebKit

class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, WebVCProtocol {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var linkField: UITextField!
    @IBOutlet weak var plotLinkField: UITextField!
    @IBOutlet weak var movieImage: UIImageView!
    
    
    var imagePicker: UIImagePickerController!
    var saveLink: String! = ""
    var savePlot: String! = ""
    
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
    
    func sendLinkToBeSaved(newURL:String, plot: Bool){
        let plotStatus = plot
        if plotStatus == true{
            self.plotLinkField.text = newURL
            savePlot = plotLinkField.text
        }else{
            self.linkField.text = newURL
            saveLink = linkField.text
        }
    }
   
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveBtnPressed(sender: AnyObject) {
        if let title = titleField.text, let img = movieImage.image, let desc = descriptionField.text {
            let imgPath = DataService.instance.saveImgPath(img)
            let post = ReviewPost(imgPath: imgPath, postTitle: title, postDesc: desc, imdbLink: saveLink, imdbPlot: savePlot)
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
    
    @IBAction func addIMDBLink(sender: AnyObject) {
        performSegueWithIdentifier("goToWebVC", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToWebVC"{
            if let webVC = segue.destinationViewController as? WebVC{
                // this sets the webVC delegate, important part of delegate/protocol:
                webVC.delegate = self
                if linkField.text != nil && linkField.text != "" {
                    print(linkField.text)
                    webVC.startURL = linkField.text!
                }else{
                    webVC.startURL = "https://www.google.com"
                }
                webVC.viewTitleString = "Add Link"
            }
        }
    }
}
