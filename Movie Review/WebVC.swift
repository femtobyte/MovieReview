//
//  WebVC.swift
//  Movie Review
//
//  Created by C Sinclair on 12/22/15.
//  Copyright © 2015 femtobyte. All rights reserved.
//

import UIKit
import WebKit

protocol WebVCProtocol{
    func sendLinkToBeSaved(newURL:String, plot: Bool)
}
class WebVC: UIViewController {

    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var container: UIView!
 
    var webView: WKWebView!
    var startURL: String!
    var viewTitleString: String = ""
    var hideBottomBar: Bool = false
    var delegate:WebVCProtocol!
    var listItem: WKBackForwardListItem!
    var plot: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        container.addSubview(webView)
        viewTitle.text = viewTitleString
        toolbar.hidden = hideBottomBar
    }
    
    override func viewDidAppear(animated: Bool) {
        let frame = CGRectMake(0, 0, container.bounds.width, container.bounds.height)
        webView.frame = frame
        if startURL != nil && startURL != ""{
            loadRequest(startURL)
        } else {
            startURL = "http://m.imdb.com"
        }
    }

    func loadRequest(urlStr: String){
        let url = NSURL(string: urlStr)!
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }
    
    @IBAction func onBackPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func saveLink(sender: AnyObject, plot: Bool){
        //gets current URL as a String
        if let newString = (webView.URL?.absoluteString)! as String! {
            self.delegate.sendLinkToBeSaved(newString, plot: plot)
        }
        dismissViewControllerAnimated(true, completion: nil)
        
        /*
        //gets the current URL, if I wanted to save link as URL
        var newURL:NSURL!
        newURL = webView.URL
        print("new URL is \(newURL)")
        */

    }
    
    @IBAction func goToGoogle(sender: AnyObject) {
        loadRequest("https://www.google.com")
    }
    
    @IBAction func saveAsPlot(sender: AnyObject) {
        plot = true
        saveLink(sender, plot: plot)
    }
    
    @IBAction func saveAsLink(sender: AnyObject) {
        plot = false
        saveLink(sender, plot: plot)
    }    
}
