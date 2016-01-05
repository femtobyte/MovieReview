//
//  DataService.swift
//  Movie Review
//
//  Created by C Sinclair on 12/17/15.
//  Copyright © 2015 femtobyte. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    static let instance = DataService()
    
    private var _linkURL:String = ""
    private var _plotURL:String = ""
    
    let KEY_POSTS = "posts"
    private var _loadedPosts = [ReviewPost]()
    
    var loadedPosts: [ReviewPost] {
        return _loadedPosts
    }
    
    var linkURL: String{
        get{
            return _linkURL
        }
        
        set{
            _linkURL = linkURL
        }
    }
    
    var plotURL: String{
        get{
            return _plotURL
        }
        
        set{
            _plotURL = plotURL
        }
    }

    func saveLink(urlString: String){
        _linkURL = urlString
    }
    
    func savePlot(url: String){
        _plotURL = url
    }
    
    func savePosts() {
        let postsData = NSKeyedArchiver.archivedDataWithRootObject(_loadedPosts)
        NSUserDefaults.standardUserDefaults().setObject(postsData, forKey: KEY_POSTS)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func loadPosts() {
        if let postsData = NSUserDefaults.standardUserDefaults().objectForKey(KEY_POSTS) as? NSData {
            if let postsArray = NSKeyedUnarchiver.unarchiveObjectWithData(postsData) as? [ReviewPost] {
                _loadedPosts = postsArray
            }
        }
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "postsLoaded", object: nil))
    }
    
    func deletePost(index:Int) {
        _loadedPosts.removeAtIndex(index)
        savePosts()
    }
    
    func imageForPath(path: String) -> UIImage? {
        let fullPath = documentsPathForFileName(path)
        let image = UIImage(named: fullPath)
        return image
    }
    
    func saveImgPath(image: UIImage)-> String {
        let imageData = UIImagePNGRepresentation(image)
        let imagePath = "image\(NSDate.timeIntervalSinceReferenceDate()).png"
        let fullPath = documentsPathForFileName(imagePath)
        imageData?.writeToFile(fullPath, atomically: true)
        return imagePath
    }
    
    func addPost(post: ReviewPost) {
        _loadedPosts.append(post)
        savePosts()
        loadPosts()
    }
    
    func documentsPathForFileName(name: String) -> String {
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let fullPath = paths[0] as NSString
            return fullPath.stringByAppendingPathComponent(name)
    }
}