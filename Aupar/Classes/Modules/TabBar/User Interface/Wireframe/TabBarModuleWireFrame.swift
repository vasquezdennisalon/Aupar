//
//  TabBarModuleWireFrame.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import Foundation
import UIKit

class TabBarModuleWireFrame: TabBarModuleWireFrameProtocol
{
    var rootWireframe: RootWireframe?
    
    static func installIntoWindow(rootWireFrame: RootWireframe, window: UIWindow, wireFrames:[TabBarViewProtocol]) -> TabBarModuleWireFrameProtocol{
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let view: TabBarModuleViewProtocol = storyboard.instantiateInitialViewController() as! TabBarModuleView
        let presenter: TabBarModulePresenterProtocol & TabBarModuleInteractorOutputProtocol = TabBarModulePresenter()
        let interactor: TabBarModuleInteractorInputProtocol = TabBarModuleInteractor()
        let wireFrame: TabBarModuleWireFrameProtocol = TabBarModuleWireFrame()
        
        wireFrame.rootWireframe = rootWireFrame
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        
        var viewControllers = [UIViewController]()
        
        for wireFrame in wireFrames {
            
            let tabBarItem = UITabBarItem()
            tabBarItem.image = wireFrame.tabIcon
            tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
            //tabBarItem.title = wireFrame.tabTitle
            
            //.appearance().setTintColor(UIColor.greenColor());
            let viewController = wireFrame.configuredViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.tabBarItem = tabBarItem
            navigationController.setNavigationBarHidden(true, animated: false)
            //navigationController.title = wireFrame.tabTitle
            viewControllers.append(navigationController)
        }
        
        //installing tabBarController into window
        //rest interactions can be done VIPER way
        let tabBarController = view as! UITabBarController
        tabBarController.viewControllers = viewControllers
        window.rootViewController = tabBarController
        
        return wireFrame
    }
    
}
