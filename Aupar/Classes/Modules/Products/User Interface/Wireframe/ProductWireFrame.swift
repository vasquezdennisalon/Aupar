//
//  ProductWireFrame.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import UIKit

class ProductWireFrame: ProductWireFrameProtocol, TabBarViewProtocol {
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    var tabIcon:UIImage = UIImage(named:"icon-productos")!
    var tabTitle:String = "Productos"
    
    func configuredViewController() -> UIViewController {
        let navController = ProductWireFrame.mainStoryboard.instantiateViewController(withIdentifier: "ProductModuleView")
        if let view = navController as? ProductViewController {
            let presenter: ProductPresenterProtocol & ProductInteractorOutputProtocol = ProductPresenter()
            let interactor: ProductInteractorInputProtocol = ProductInteractor()
            let remoteDatamanager: ProductRemoteDataManagerInputProtocol = ProductRemoteDataManager()
            let wireFrame: ProductWireFrameProtocol = ProductWireFrame()
            
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
