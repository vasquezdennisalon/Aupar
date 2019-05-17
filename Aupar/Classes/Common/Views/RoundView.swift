//
//  Interaccion.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/17/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import UIKit

@IBDesignable class RoundView: UIView {
    
    @IBInspectable public var radius:CGFloat = 2.0{
        didSet{
            self.layer.cornerRadius = radius
        }
    }

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
