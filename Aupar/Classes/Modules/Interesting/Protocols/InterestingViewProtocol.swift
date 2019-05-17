//
//  InterestingViewProtocol.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import UIKit

/**** Methods for communication PRESENTER -> VIEW ****/
protocol InterestingViewProtocol: class {
    var presenter: InterestingPresenterProtocol? { get set }
    
    //func didInsertContact(_ contact: Interaccion)
    //func reloadInterface(with contacts: [Interaccion])
}

/**** Methods for communication PRESENTER -> WIREFRAME ****/
protocol InterestingWireFrameProtocol: class {
    //static func configuredViewController() -> UIViewController
}

/**** Methods for communication VIEW -> PRESENTER ****/
protocol InterestingPresenterProtocol: class {
    var view: InterestingViewProtocol? { get set }
    var interactor: InterestingInteractorInputProtocol? { get set }
    var wireFrame: InterestingWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

/**** Methods for communication INTERACTOR -> PRESENTER ****/
protocol InterestingInteractorOutputProtocol: class {
    //func didRetrieveContacts(_ interacciones: [Interaccion])
}

/**** Methods for communication PRESENTER -> INTERACTOR ****/
protocol InterestingInteractorInputProtocol: class {
    var presenter: InterestingInteractorOutputProtocol? { get set }
    var localDatamanager: InterestingLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: InterestingRemoteDataManagerInputProtocol? { get set }
    
}

/**** Methods for communication INTERACTOR -> DATAMANAGER ****/
protocol InterestingDataManagerInputProtocol: class {
    
}

/**** Methods for communication INTERACTOR -> LOCALDATAMANAGER ****/
protocol InterestingLocalDataManagerInputProtocol: class {
    //func retrieveContactList(callback: @escaping ([Interaccion]) -> ())
}

/**** Methods for communication INTERACTOR -> REMOTEDATAMANAGER ****/
protocol InterestingRemoteDataManagerInputProtocol: class {
    //func retrieveContactList(callback: @escaping ([Interaccion]) -> ())
}

