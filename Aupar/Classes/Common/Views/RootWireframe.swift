//
//  RootWireframe.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import Foundation
import UIKit

class RootWireframe: NSObject
{
    var window: UIWindow!
    var tabBarModuleWireframe: TabBarModuleWireFrameProtocol?
    
    init(window: UIWindow){
        super.init()
        self.window = window
    }
    
    func installViewIntoRootViewController(){
        
        var wireframes = [TabBarViewProtocol]()
        /** Append Notification View To TabBarModule **/
        let notificationWireFrame : NotificationWireFrameProtocol = NotificationWireFrame()
        wireframes.append(notificationWireFrame as! TabBarViewProtocol)
        /** Append Interesting View To TabBarModule **/
        let interestingWireFrame : InterestingWireFrameProtocol = InterestingWireFrame()
        wireframes.append(interestingWireFrame as! TabBarViewProtocol)
        /** Append Discover View To TabBarModule **/
        let discoverWireFrame : DiscoverWireFrameProtocol = DiscoverWireFrame()
        wireframes.append(discoverWireFrame as! TabBarViewProtocol)
        /** Append Product View To TabBarModule **/
        let productsWireFrame : ProductWireFrameProtocol = ProductWireFrame()
        wireframes.append(productsWireFrame as! TabBarViewProtocol)
        /** Append Cart View To TabBarModule **/
        let cartWireFrame : CartWireFrameProtocol = CartWireFrame()
        wireframes.append(cartWireFrame as! TabBarViewProtocol)
        
        self.tabBarModuleWireframe = TabBarModuleWireFrame.installIntoWindow(rootWireFrame: self, window: self.window, wireFrames: wireframes)
    }
}
