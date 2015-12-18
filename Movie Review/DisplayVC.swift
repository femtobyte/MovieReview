//
//  DisplayVC.swift
//  Movie Review
//
//  Created by C Sinclair on 12/16/15.
//  Copyright © 2015 femtobyte. All rights reserved.
//

import UIKit

class DisplayVC: UIViewController {
    
    @IBOutlet weak var displayImg: UIImageView!
    @IBOutlet weak var displayTitle: UILabel!
    @IBOutlet weak var displayDesc: UILabel!
    @IBOutlet weak var displayLink: UILabel!
    @IBOutlet weak var displayPlot: UILabel!
    
    var transferPost: ReviewPost!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDisplay(transferPost)
    }
    
    func configureDisplay(post: ReviewPost){
        displayTitle.text = post.postTitle
        displayDesc.text = post.postDesc
        displayLink.text = post.imdbLink
        displayImg.image = DataService.instance.imageForPath(post.imgPath)
        displayPlot.text = post.imdbPlot
    }

 
    
    override func viewWillAppear(animated: Bool) {


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
