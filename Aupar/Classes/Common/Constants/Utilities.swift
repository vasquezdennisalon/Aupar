//
//  File.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import Foundation
import UIKit

struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }()
}

class Utilities{
    static let shared = Utilities()
    var naranja:UIColor!
    var gris:UIColor!
    var azul:UIColor!
    var reporting:UIColor!
    var descarting:UIColor!
    
    init(){
        self.naranja = UIColor.init(red: 251.0/255.0, green: 105.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        //self.gris = self.hexStringToUIColor(hex: "a6a8ab")
        self.azul = UIColor.init(red: 66.0/255.0, green: 76.0/255.0, blue: 159.0/255.0, alpha: 1.0)
        self.gris = UIColor.init(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        self.reporting = UIColor.init(red: 237.0/255.0, green: 28.0/255.0, blue: 36.0/255.0, alpha: 1.0)
        self.descarting = UIColor.init(red: 0.0/255.0, green: 174.0/255.0, blue: 239.0/255.0, alpha: 1.0)
    }
    
    // Returns the navigation controller if it exists
    func getNavigationController() -> UINavigationController? {
        
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController  {
            
            return navigationController as? UINavigationController
        }
        return nil
    }
    
    func getCurrentViewController() -> UIViewController? {
        
        // If the root view is a navigation controller, we can just return the visible ViewController
        if let navigationController = getNavigationController() {
            
            return navigationController.visibleViewController
        }
        
        // Otherwise, we must get the root UIViewController and iterate through presented views
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            
            var currentController: UIViewController! = rootController
            
            // Each ViewController keeps track of the view it has presented, so we
            // can move from the head to the tail, which will always be the current view
            while( currentController.presentedViewController != nil ) {
                
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
    }

}
