//
//  TabBarProtocol.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarViewProtocol {
    
    var tabIcon:UIImage { get }
    var tabTitle:String { get }
    
    func configuredViewController() -> UIViewController
}

protocol TabBarModuleViewProtocol: class
{
    var presenter: TabBarModulePresenterProtocol? { get set }
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */
}

protocol TabBarModuleWireFrameProtocol: class
{
    static func installIntoWindow(rootWireFrame: RootWireframe, window: UIWindow, wireFrames:[TabBarViewProtocol]) -> TabBarModuleWireFrameProtocol
    var rootWireframe: RootWireframe? { get set }
    /**
     * Add here your methods for communication PRESENTER -> WIREFRAME
     */
}

protocol TabBarModulePresenterProtocol: class
{
    var view: TabBarModuleViewProtocol? { get set }
    var interactor: TabBarModuleInteractorInputProtocol? { get set }
    var wireFrame: TabBarModuleWireFrameProtocol? { get set }
    /**
     * Add here your methods for communication VIEW -> PRESENTER
     */
}

protocol TabBarModuleInteractorOutputProtocol: class
{
    /**
     * Add here your methods for communication INTERACTOR -> PRESENTER
     */
}

protocol TabBarModuleInteractorInputProtocol: class
{
    var presenter: TabBarModuleInteractorOutputProtocol? { get set }
    /**
     * Add here your methods for communication PRESENTER -> INTERACTOR
     */
}
