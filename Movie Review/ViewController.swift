//
//  ViewController.swift
//  Movie Review
//
//  Created by C Sinclair on 12/14/15.
//  Copyright © 2015 femtobyte. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        DataService.instance.loadPosts()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onPostsLoaded:", name: "postsLoaded", object: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reviewPost = DataService.instance.loadedPosts[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("ReviewPostCell") as? ReviewPostCell {
            cell.configureCell(reviewPost)
            return cell
        } else {
            let cell = ReviewPostCell()
            cell.configureCell(reviewPost)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 127
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.loadedPosts.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("DisplayVC", sender: indexPath)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let index:Int = indexPath.row
        if editingStyle == UITableViewCellEditingStyle.Delete{
            DataService.instance.deletePost(index)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "DisplayVC") {
            if let indexPath = sender as? NSIndexPath {
                if let displayVC = segue.destinationViewController as? DisplayVC {
                    displayVC.transferPost = DataService.instance.loadedPosts[indexPath.row]
                }
            }
        }
    }
  
    func onPostsLoaded(notif: AnyObject){
        tableView.reloadData()
    }
}

