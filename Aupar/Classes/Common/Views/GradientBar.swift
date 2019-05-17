//
//  Interaccion.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/17/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import UIKit

@IBDesignable class GradientBar: UIView {
    var gradientLayer:CAGradientLayer  = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBInspectable var gradient: UIColor! = UIColor.white{
        didSet{
            updateGradient()
        }
    }
    
    func updateGradient(){
        gradientLayer.removeFromSuperlayer()
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.frame.height)
        gradientLayer.colors = [gradient.cgColor,gradient.withAlphaComponent(0.0).cgColor]
        gradientLayer.locations = [0.0, 0.9]
        self.layer.addSublayer(gradientLayer)
    
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
