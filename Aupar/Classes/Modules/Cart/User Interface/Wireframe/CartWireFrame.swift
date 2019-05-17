//
//  CartWireFrame.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import UIKit

class CartWireFrame: CartWireFrameProtocol, TabBarViewProtocol {
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    var tabIcon:UIImage = UIImage(named:"icon-carretilla")!
    var tabTitle:String = "Carretilla"
    
    func configuredViewController() -> UIViewController {
        let navController = CartWireFrame.mainStoryboard.instantiateViewController(withIdentifier: "CartModuleView")
        if let view = navController as? CartViewController {
            let presenter: CartPresenterProtocol & CartInteractorOutputProtocol = CartPresenter()
            let interactor: CartInteractorInputProtocol = CartInteractor()
            let remoteDatamanager: CartRemoteDataManagerInputProtocol = CartRemoteDataManager()
            let wireFrame: CartWireFrameProtocol = CartWireFrame()
            
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

