//
//  Extensions.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func topMostViewController() -> UIViewController {
        
        if let presented = self.presentedViewController {
            return presented.topMostViewController()
        }
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }
        
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }
        
        return self
    }
}

extension UIView {
    func addDashedLine(strokeColor: UIColor, lineWidth: CGFloat, fullscreen: Bool = false) {
        backgroundColor = .clear
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "DashedTopLine"
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [4, 4]
        let path = CGMutablePath()
        path.move(to: CGPoint.zero)
        if fullscreen{
            path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
        }else{
            path.addLine(to: CGPoint(x: frame.width, y: 0))
        }
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}

extension UITableView {
    var swipeCells: [SwipeTableViewCell] {
        return visibleCells.compactMap({ $0 as? SwipeTableViewCell })
    }
    
    func hideSwipeCell() {
        swipeCells.forEach { $0.hideSwipe(animated: true) }
    }
}

/*UIPanGestureRecognizer */
extension UIPanGestureRecognizer {
    func elasticTranslation(in view: UIView?, withLimit limit: CGSize, fromOriginalCenter center: CGPoint, applyingRatio ratio: CGFloat = 0.20) -> CGPoint {
        let translation = self.translation(in: view)
        
        guard let sourceView = self.view else {
            return translation
        }
        
        let updatedCenter = CGPoint(x: center.x + translation.x, y: center.y + translation.y)
        let distanceFromCenter = CGSize(width: abs(updatedCenter.x - sourceView.bounds.midX),
                                        height: abs(updatedCenter.y - sourceView.bounds.midY))
        
        let inverseRatio = 1.0 - ratio
        let scale: (x: CGFloat, y: CGFloat) = (updatedCenter.x < sourceView.bounds.midX ? -1 : 1, updatedCenter.y < sourceView.bounds.midY ? -1 : 1)
        let x = updatedCenter.x - (distanceFromCenter.width > limit.width ? inverseRatio * (distanceFromCenter.width - limit.width) * scale.x : 0)
        let y = updatedCenter.y - (distanceFromCenter.height > limit.height ? inverseRatio * (distanceFromCenter.height - limit.height) * scale.y : 0)
        
        return CGPoint(x: x, y: y)
    }
}

/* UISearchBar */
public extension UISearchBar {
    
    var textField:UITextField? {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return nil}
        return tf
    }
}
