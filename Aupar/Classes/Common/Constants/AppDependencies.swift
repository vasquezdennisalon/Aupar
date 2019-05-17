//
//  AppDependencies.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies{
    
    class func initWithWindow(window: UIWindow) -> AppDependencies
    {
        let obj = AppDependencies()
        
        obj.configureDependencies(window: window)
        
        return obj
    }
    
    
    var rootWireframe: RootWireframe?
    
    func configureDependencies(window: UIWindow)
    {
        rootWireframe = RootWireframe.init(window: window)
        rootWireframe!.installViewIntoRootViewController()
        
    }
}
