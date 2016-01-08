//
//  DisplayVC.swift
//  Movie Review
//
//  Created by C Sinclair on 12/16/15.
//  Copyright © 2015 femtobyte. All rights reserved.
//

import UIKit

class DisplayVC: UIViewController {
    
    @IBOutlet weak var displayViewTitle: UILabel!
    @IBOutlet weak var displayImg: UIImageView!
    @IBOutlet weak var displayDesc: UILabel!
    
    var transferPost: ReviewPost!
    var goToLink: String!
    var button: UIBarButtonItem!
    var linkText: String!
    var plotText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayImg.layer.cornerRadius = 10.0
        displayImg.clipsToBounds = true
        configureDisplay(self.transferPost)
    }
    
    func configureDisplay(post: ReviewPost){
        displayViewTitle.text = post.postTitle
        displayDesc.text = post.postDesc
        linkText = post.imdbLink
        displayImg.image = DataService.instance.imageForPath(post.imgPath)
        plotText = post.imdbPlot
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onBackBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    @IBAction func onMovieInfo(sender: AnyObject) {
        button = sender as? UIBarButtonItem
        performSegueWithIdentifier("displayToWebVC", sender: button)

    }
    @IBAction func onMoviePlot(sender: AnyObject) {
        button = sender as? UIBarButtonItem
        performSegueWithIdentifier("displayToWebVC", sender: button)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "displayToWebVC"{
            if let webVC = segue.destinationViewController as? WebVC{
                if button!.tag == 1 {
                    webVC.startURL = "\(linkText)"
                    webVC.viewTitleString = "Movie Link"
                }else if button!.tag == 2{
                    webVC.startURL = "\(plotText)"
                    webVC.viewTitleString = "Movie Plot"
                }else{
                    webVC.startURL = "https://www.google.com"
                }
                webVC.hideBottomBar = true
            }
        }
    }
}
