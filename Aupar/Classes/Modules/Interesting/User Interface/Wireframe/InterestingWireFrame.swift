//
//  InterestingWireFrame.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import UIKit

class InterestingWireFrame: InterestingWireFrameProtocol, TabBarViewProtocol {
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    var tabIcon:UIImage = UIImage(named:"icon-conquistados")!
    var tabTitle:String = "Coqnuistados"
    
    func configuredViewController() -> UIViewController {
        let navController = InterestingWireFrame.mainStoryboard.instantiateViewController(withIdentifier: "InterestingModuleView")
        if let view = navController as? InterestingViewController {
            let presenter: InterestingPresenterProtocol & InterestingInteractorOutputProtocol = InterestingPresenter()
            let interactor: InterestingInteractorInputProtocol = InterestingInteractor()
            let remoteDatamanager: InterestingRemoteDataManagerInputProtocol = InterestingRemoteDataManager()
            let wireFrame: InterestingWireFrameProtocol = InterestingWireFrame()
            
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
