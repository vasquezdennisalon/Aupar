//
//  NotificationProtocols.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import UIKit

/**** Methods for communication PRESENTER -> VIEW ****/
protocol NotificationViewProtocol: class {
    var presenter: NotificationPresenterProtocol? { get set }
    
    //func didInsertContact(_ contact: Interaccion)
    //func reloadInterface(with contacts: [Interaccion])
}

/**** Methods for communication PRESENTER -> WIREFRAME ****/
protocol NotificationWireFrameProtocol: class {
    //static func configuredViewController() -> UIViewController
}

/**** Methods for communication VIEW -> PRESENTER ****/
protocol NotificationPresenterProtocol: class {
    var view: NotificationViewProtocol? { get set }
    var interactor: NotificationInteractorInputProtocol? { get set }
    var wireFrame: NotificationWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

/**** Methods for communication INTERACTOR -> PRESENTER ****/
protocol NotificationInteractorOutputProtocol: class {
    //func didRetrieveContacts(_ interacciones: [Interaccion])
}

/**** Methods for communication PRESENTER -> INTERACTOR ****/
protocol NotificationInteractorInputProtocol: class {
    var presenter: NotificationInteractorOutputProtocol? { get set }
    var localDatamanager: NotificationLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: NotificationRemoteDataManagerInputProtocol? { get set }
    
}

/**** Methods for communication INTERACTOR -> DATAMANAGER ****/
protocol NotificationDataManagerInputProtocol: class {
    
}

/**** Methods for communication INTERACTOR -> LOCALDATAMANAGER ****/
protocol NotificationLocalDataManagerInputProtocol: class {
    //func retrieveContactList(callback: @escaping ([Interaccion]) -> ())
}

/**** Methods for communication INTERACTOR -> REMOTEDATAMANAGER ****/
protocol NotificationRemoteDataManagerInputProtocol: class {
    //func retrieveContactList(callback: @escaping ([Interaccion]) -> ())
}
