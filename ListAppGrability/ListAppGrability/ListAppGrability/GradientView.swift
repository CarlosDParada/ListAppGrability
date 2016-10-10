//
//  GradientView.swift
//  ListAppGrability
//
//  Created by Carlos Parada on 10/10/16.
//  Copyright © 2016 carlosparada. All rights reserved.
//

import Foundation
import UIKit
class GradientView: UIView {
    override class func layerClass() -> AnyClass { return CAGradientLayer.self }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = self.layer as! CAGradientLayer
        gradientLayer.colors = [ UIColor.lightBlue.CGColor ,UIColor.lightGreen.CGColor]
    }
}
