//
//  DiscoverWireFrame.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import UIKit

class DiscoverWireFrame: DiscoverWireFrameProtocol, TabBarViewProtocol {
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    var tabIcon:UIImage = UIImage(named:"icon-descubre")!
    var tabTitle:String = "Descubre"
    
    func configuredViewController() -> UIViewController {
        let navController = DiscoverWireFrame.mainStoryboard.instantiateViewController(withIdentifier: "DiscoverModuleView")
        if let view = navController as? DiscoverViewController {
            let presenter: DiscoverPresenterProtocol & DiscoverInteractorOutputProtocol = DiscoverPresenter()
            let interactor: DiscoverInteractorInputProtocol = DiscoverInteractor()
            let remoteDatamanager: DiscoverRemoteDataManagerInputProtocol = DiscoverRemoteDataManager()
            let wireFrame: DiscoverWireFrameProtocol = DiscoverWireFrame()
            
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

    func presentAddContactScreen(from view: DiscoverViewProtocol) {
        
    }
}
