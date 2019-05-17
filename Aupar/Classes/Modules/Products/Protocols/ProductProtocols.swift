//
//  ProductProtocols.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import UIKit

/**** Methods for communication PRESENTER -> VIEW ****/
protocol ProductViewProtocol: class {
    var presenter: ProductPresenterProtocol? { get set }
    
    //func didInsertContact(_ contact: Interaccion)
    //func reloadInterface(with contacts: [Interaccion])
}

/**** Methods for communication PRESENTER -> WIREFRAME ****/
protocol ProductWireFrameProtocol: class {
    //static func configuredViewController() -> UIViewController
}

/**** Methods for communication VIEW -> PRESENTER ****/
protocol ProductPresenterProtocol: class {
    var view: ProductViewProtocol? { get set }
    var interactor: ProductInteractorInputProtocol? { get set }
    var wireFrame: ProductWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

/**** Methods for communication INTERACTOR -> PRESENTER ****/
protocol ProductInteractorOutputProtocol: class {
    //func didRetrieveContacts(_ interacciones: [Interaccion])
}

/**** Methods for communication PRESENTER -> INTERACTOR ****/
protocol ProductInteractorInputProtocol: class {
    var presenter: ProductInteractorOutputProtocol? { get set }
    var localDatamanager: ProductLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ProductRemoteDataManagerInputProtocol? { get set }
    
}

/**** Methods for communication INTERACTOR -> DATAMANAGER ****/
protocol ProductDataManagerInputProtocol: class {
    
}

/**** Methods for communication INTERACTOR -> LOCALDATAMANAGER ****/
protocol ProductLocalDataManagerInputProtocol: class {
    //func retrieveContactList(callback: @escaping ([Interaccion]) -> ())
}

/**** Methods for communication INTERACTOR -> REMOTEDATAMANAGER ****/
protocol ProductRemoteDataManagerInputProtocol: class {
    //func retrieveContactList(callback: @escaping ([Interaccion]) -> ())
}

