//
//  ReviewPostCell.swift
//  Movie Review
//
//  Created by C Sinclair on 12/14/15.
//  Copyright © 2015 femtobyte. All rights reserved.
//

import UIKit

class ReviewPostCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var reviewLbl: UILabel!
    @IBOutlet weak var reviewDesc: UILabel! 
    @IBOutlet weak var imdbLink: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        img.layer.cornerRadius = 15.0
        img.clipsToBounds = true
    }
    
    func configureCell(post: ReviewPost){
        reviewLbl.text = post.postTitle		
        reviewDesc.text = post.postDesc
        imdbLink.text = post.imdbLink
        img.image = DataService.instance.imageForPath(post.imgPath)
    }
}
