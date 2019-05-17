//
//  NotificationWireFrame.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//


import UIKit

class NotificationWireFrame: NotificationWireFrameProtocol, TabBarViewProtocol {
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    var tabIcon:UIImage = UIImage(named:"icon-notificacion")!
    var tabTitle:String = "News"
    
    func configuredViewController() -> UIViewController {
        let navController = NotificationWireFrame.mainStoryboard.instantiateViewController(withIdentifier: "NotificationModuleView")
        if let view = navController as? NotificationViewController {
            let presenter: NotificationPresenterProtocol & NotificationInteractorOutputProtocol = NotificationPresenter()
            let interactor: NotificationInteractorInputProtocol = NotificationInteractor()
            let remoteDatamanager: NotificationRemoteDataManagerInputProtocol = NotificationRemoteDataManager()
            let wireFrame: NotificationWireFrameProtocol = NotificationWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDatamanager = remoteDatamanager
            
            return navController
        }
        return UIViewController()
    }
}
