//
//  CartProtocols.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import UIKit

/**** Methods for communication PRESENTER -> VIEW ****/
protocol CartViewProtocol: class {
    var presenter: CartPresenterProtocol? { get set }
    
    //func didInsertContact(_ contact: Interaccion)
    //func reloadInterface(with contacts: [Interaccion])
}

/**** Methods for communication PRESENTER -> WIREFRAME ****/
protocol CartWireFrameProtocol: class {
    //static func configuredViewController() -> UIViewController
}

/**** Methods for communication VIEW -> PRESENTER ****/
protocol CartPresenterProtocol: class {
    var view: CartViewProtocol? { get set }
    var interactor: CartInteractorInputProtocol? { get set }
    var wireFrame: CartWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

/**** Methods for communication INTERACTOR -> PRESENTER ****/
protocol CartInteractorOutputProtocol: class {
    //func didRetrieveContacts(_ interacciones: [Interaccion])
}

/**** Methods for communication PRESENTER -> INTERACTOR ****/
protocol CartInteractorInputProtocol: class {
    var presenter: CartInteractorOutputProtocol? { get set }
    var localDatamanager: CartLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: CartRemoteDataManagerInputProtocol? { get set }
    
}

/**** Methods for communication INTERACTOR -> DATAMANAGER ****/
protocol CartDataManagerInputProtocol: class {
    
}

/**** Methods for communication INTERACTOR -> LOCALDATAMANAGER ****/
protocol CartLocalDataManagerInputProtocol: class {
    //func retrieveContactList(callback: @escaping ([Interaccion]) -> ())
}

/**** Methods for communication INTERACTOR -> REMOTEDATAMANAGER ****/
protocol CartRemoteDataManagerInputProtocol: class {
    //func retrieveContactList(callback: @escaping ([Interaccion]) -> ())
}


