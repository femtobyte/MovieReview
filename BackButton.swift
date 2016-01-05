//
//  BackButton.swift
//  Movie Review
//
//  Created by C Sinclair on 1/4/16.
//  Copyright © 2016 femtobyte. All rights reserved.
//

import UIKit

class BackButton: UIButton {

    override func drawRect(rect: CGRect) {
        BackButtonStyleKit.drawBackButton()
    }
    

}
