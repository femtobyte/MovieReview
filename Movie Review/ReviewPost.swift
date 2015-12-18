//
//  ReviewPost.swift
//  Movie Review
//
//  Created by C Sinclair on 12/14/15.
//  Copyright © 2015 femtobyte. All rights reserved.
//

import Foundation


class ReviewPost: NSObject, NSCoding {
    
    private var _postTitle: String!
    private var _postDesc: String!
    private var _imdbLink: String!
    private var _imdbPlot: String!
    private var _imgPath: String!
    
    var imgPath: String {
        return _imgPath
    }
    
    var postTitle: String {
        return _postTitle
    }
    
    var postDesc: String {
        return _postDesc
    }
    
    var imdbLink: String {
        return _imdbLink
    }
    
    var imdbPlot: String {
        return _imdbPlot
    }
    
    init(imgPath: String, postTitle: String, postDesc: String, imdbLink: String, imdbPlot: String) {
        self._imgPath = imgPath
        self._postTitle = postTitle
        self._postDesc = postDesc
        self._imdbLink = imdbLink
        self._imdbPlot = imdbPlot
    }
    
    override init(){}
    
    required convenience init?(coder aDecoder: NSCoder){
        self.init()
        self._imgPath = aDecoder.decodeObjectForKey("imgPath") as? String
        self._postTitle = aDecoder.decodeObjectForKey("postTitle") as? String
        self._postDesc = aDecoder.decodeObjectForKey("postDesc") as? String
        self._imdbLink = aDecoder.decodeObjectForKey("imdbLink") as? String
        self._imdbPlot = aDecoder.decodeObjectForKey("imdbPlot") as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self._imgPath, forKey: "imgPath")
        aCoder.encodeObject(self._postTitle, forKey: "postTitle")
        aCoder.encodeObject(self._postDesc, forKey: "postDesc")
        aCoder.encodeObject(self._imdbLink, forKey: "imdbLink")
        aCoder.encodeObject(self._imdbPlot, forKey: "imdbPlot")
    }

}

