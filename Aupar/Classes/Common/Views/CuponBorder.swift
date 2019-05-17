//
//  Interaccion.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/17/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import Foundation
import UIKit

class CuponBorder: UIView {

    override func draw(_ rect: CGRect) {
        let area = rect
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
        shadow.shadowOffset = CGSize(width: 0, height: 0)
        shadow.shadowBlurRadius = 5
        
        //// Border Drawing
        let borderPath = UIBezierPath()
        borderPath.move(to: CGPoint(x: area.minX + 26.65, y: area.minY + 0.33))
        borderPath.addLine(to: CGPoint(x: area.minX + 26.84, y: area.minY + 0.37))
        borderPath.addCurve(to: CGPoint(x: area.minX + 29.63, y: area.minY + 3.16), controlPoint1: CGPoint(x: area.minX + 28.14, y: area.minY + 0.85), controlPoint2: CGPoint(x: area.minX + 29.15, y: area.minY + 1.86))
        borderPath.addCurve(to: CGPoint(x: area.minX + 30, y: area.minY + 7.64), controlPoint1: CGPoint(x: area.minX + 30, y: area.minY + 4.34), controlPoint2: CGPoint(x: area.minX + 30, y: area.minY + 5.44))
        borderPath.addCurve(to: CGPoint(x: area.minX + 30, y: area.minY + 25), controlPoint1: CGPoint(x: area.minX + 30, y: area.minY + 7.64), controlPoint2: CGPoint(x: area.minX + 30, y: area.minY + 14.9))
        borderPath.addCurve(to: CGPoint(x: area.minX + 27.48, y: area.minY + 25.14), controlPoint1: CGPoint(x: area.minX + 29.15, y: area.minY + 25), controlPoint2: CGPoint(x: area.minX + 28.31, y: area.minY + 25.05))
        borderPath.addCurve(to: CGPoint(x: area.minX + 8, y: area.minY + 47), controlPoint1: CGPoint(x: area.minX + 16.52, y: area.minY + 26.39), controlPoint2: CGPoint(x: area.minX + 8, y: area.minY + 35.7))
        borderPath.addCurve(to: CGPoint(x: area.minX + 30, y: area.minY + 69), controlPoint1: CGPoint(x: area.minX + 8, y: area.minY + 59.15), controlPoint2: CGPoint(x: area.minX + 17.85, y: area.minY + 69))
        borderPath.addCurve(to: CGPoint(x: area.minX + 30, y: area.minY + 86.36), controlPoint1: CGPoint(x: area.minX + 30, y: area.minY + 79.1), controlPoint2: CGPoint(x: area.minX + 30, y: area.minY + 86.36))
        borderPath.addCurve(to: CGPoint(x: area.minX + 29.67, y: area.minY + 90.65), controlPoint1: CGPoint(x: area.minX + 30, y: area.minY + 88.56), controlPoint2: CGPoint(x: area.minX + 30, y: area.minY + 89.66))
        borderPath.addLine(to: CGPoint(x: area.minX + 29.63, y: area.minY + 90.84))
        borderPath.addCurve(to: CGPoint(x: area.minX + 26.84, y: area.minY + 93.63), controlPoint1: CGPoint(x: area.minX + 29.15, y: area.minY + 92.14), controlPoint2: CGPoint(x: area.minX + 28.14, y: area.minY + 93.15))
        borderPath.addCurve(to: CGPoint(x: area.minX + 22.36, y: area.minY + 94), controlPoint1: CGPoint(x: area.minX + 25.66, y: area.minY + 94), controlPoint2: CGPoint(x: area.minX + 24.56, y: area.minY + 94))
        borderPath.addLine(to: CGPoint(x: area.minX, y: area.minY + 94))
        borderPath.addLine(to: CGPoint(x: area.minX, y: area.minY))
        borderPath.addLine(to: CGPoint(x: area.minX + 22.36, y: area.minY))
        borderPath.addCurve(to: CGPoint(x: area.minX + 26.65, y: area.minY + 0.33), controlPoint1: CGPoint(x: area.minX + 24.56, y: area.minY), controlPoint2: CGPoint(x: area.minX + 25.66, y: area.minY))
        borderPath.close()
        context.saveGState()
        context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        Utilities.shared.naranja.setFill()
        //UIColor.init(red: 251.0/255.0, green: 105.0/255.0, blue: 0.0/255.0, alpha: 1.0).setFill()
        borderPath.fill()
        context.restoreGState()
    }
}
